Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <427F0F94.3060806@xmission.com>
From: Brad Midgley <bmidgley@xmission.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
References: <42792979.90109@xmission.com>	 <20050507031314.548afb03.henryk@ploetzli.ch>	 <1115429201.9031.5.camel@pegasus> <1115494053.9031.15.camel@pegasus>	 <20050507222047.430774e9.henryk@ploetzli.ch> <1115498715.9031.24.camel@pegasus> <427F0492.1090007@xmission.com>
In-Reply-To: <427F0492.1090007@xmission.com>
Content-Type: text/plain; charset=us-ascii; format=flowed
Subject: Re: [Bluez-devel] yes, a2dp timing is whacked
Sender: bluez-devel-admin@lists.sourceforge.net
Errors-To: bluez-devel-admin@lists.sourceforge.net
Reply-To: bluez-devel@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
Date: Mon, 09 May 2005 01:21:56 -0600

I think my hack introduced timing issues of its own... tomorrow I'll fix 
it up with code that uses a ring buffer and bleeds from the ring in the 
sighandler.

Brad Midgley wrote:
> Guys,
> 
> I put a rough proof-of-concept implementation together using setitimer. 
> (Yes, it's gross and the signal handler doesn't actually do any work, 
> just indicates that the interval is over)
> 
> The music seems to be timed right but it's a very "noisy" signal on the 
> hp headset. Any ideas?
> 
> I didn't commit it because it's so ugly.
> 
> Brad
> 
> Marcel Holtmann wrote:
> 
>> Hi Henryk,
>>
>>
>>>> So the best thing is too encode two or three full AVDTP frames in
>>>> advance and have them ready to send. The sending can't be controlled
>>>> be usleep(). We need a time that kicks in every whatever msec and
>>>> makes us to transmit the next frame.
>>>
>>>
>>> That's what I would favour. According to the libc manual setitimer()
>>> would be the function of choice, if nobody else has a better idea (RTC,
>>> anyone?).
>>
>>
>>
>> so in general the time that a SBC frame is calculated for, is always the
>> same if we don't change the parameters, right?
>>
>> Using the ITIMER_REAL domain may works and since you can setup your
>> timer in microseconds, then this would be the way to go.
> 
> 
> ------------------------------------------------------------------------
> 
> Index: a2play.c
> ===================================================================
> RCS file: /cvsroot/bluetooth-alsa/btsco/a2play.c,v
> retrieving revision 1.64
> diff -u -b -B -w -p -r1.64 a2play.c
> --- a2play.c	7 May 2005 02:43:00 -0000	1.64
> +++ a2play.c	9 May 2005 06:30:36 -0000
> @@ -56,6 +56,7 @@
>  #define BUFS 1024
>  
>  static volatile int terminate = 0;
> +static volatile int xmitpause = 0;
>  static int cmdfd;
>  
>  struct sbc_frame_header sbc_info;
> @@ -102,6 +103,16 @@ static void sig_term(int sig)
>  	terminate = 1;
>  }
>  
> +static void sig_alrm(int sig)
> +{
> +	struct sigaction sa;
> +	memset(&sa, 0, sizeof(sa));
> +	sa.sa_flags = SA_NOCLDSTOP;
> +	sa.sa_handler = sig_alrm;
> +	sigaction(SIGALRM, &sa, NULL);
> +	xmitpause = 0;
> +}
> +
>  // Usage
>  static void usage()
>  {
> @@ -404,6 +415,8 @@ s_config was set from sbc_info before:
>  
>  int main(int argc, char *argv[])
>  {
> +	int timerset = 0;
> +	struct itimerval itimer;
>  	struct sigaction sa;
>  	struct timeval start, end;
>  	int streamfd;
> @@ -619,6 +632,8 @@ int main(int argc, char *argv[])
>  
>  	timestamp = 0;
>  
> +	sig_alrm(0);
> +
>  	while (!terminate) {
>  
>  		// a2dp headers: avdtp p.45
> @@ -698,8 +713,18 @@ int main(int argc, char *argv[])
>  
>  			memcpy(buf + sizeof(packet_header), &payload_header, sizeof(payload_header));
>  			write(streamfd, buf, psize);
> -			//printf("\nSending packet:%d, size %d no. of sbc frames:%d", seq_num, psize, payload_header.frame_count);
>  
> +			if(!timerset) {
> +				timerset = 1;
> +				itimer.it_interval.tv_sec = itimer.it_value.tv_sec = 0;
> +				itimer.it_interval.tv_usec = itimer.it_value.tv_usec = (sleeptime*95)/100;
> +				if(setitimer(ITIMER_REAL, &itimer, NULL)) printf("couldn't setitimer\n");
> +			}
> +
> +			while(xmitpause) usleep(10);
> +			xmitpause = 1;
> +#if 0
> +			//printf("\nSending packet:%d, size %d no. of sbc frames:%d", seq_num, psize, payload_header.frame_count);
>  			pending++;
>  
>  			if (pending > 4) {
> @@ -717,7 +742,7 @@ int main(int argc, char *argv[])
>  				sleeptime = 0;
>  				pending = 0;
>  			}
> -
> +#endif
>  			/* END: NONSPECAUDIO == FALSE */
>  		}
>  


-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
