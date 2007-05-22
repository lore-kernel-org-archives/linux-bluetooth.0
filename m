Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <46532D87.6000400@nnytech.net>
Date: Tue, 22 May 2007 13:51:03 -0400
From: John Feig <feig@nnytech.net>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <200705170207.52710.bluez-devel@huitl.de>	<d89ddf300705162042j1850b997wd069bae29e813d29@mail.gmail.com>	<200705171521.38889.bluez-devel@huitl.de>	<464C7616.9070900@nnytech.net><d89ddf300705180613u5c24ed8brab0acf3f7ee65280@mail.gmail.com>	<464DCCC4.90300@nnytech.net>	<CE5216C10C83944D9FD37B65CD33F3970CF4E1@mplex01.mpl.access-company.com>
	<4652FEAE.1000602@nnytech.net>
In-Reply-To: <4652FEAE.1000602@nnytech.net>
Subject: Re: [Bluez-devel] RE :  Frequent headset disconnects
Reply-To: feig@nnytech.net,
        BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

John Feig wrote:
> Frederic Dalleau wrote:
>> Hi,
>> I did some recent changes and there are things to solve.
>> I don't have access to a linux computer right now. In your case, 
>> enclosing the write call in a while loop may help.
>>
>> do {
>>             if ((written = write(a2dp->sk, a2dp->buf, a2dp->len)) != 
>> a2dp->len) {
>>                         // Return the error
>>                         result = written;
>>             }
>> } while(written<0 && errno==EAGAIN);
>>
>> Remove the DBG call.
>>
>> However, it may burn cpu time if you don't wait a little before 
>> retrying.
>>
>>
>> The best solution would be to find why the packet must be resent.
>> Let us know if you get something.
>>
>> Frederic.
>>   
> Ok, I plugged that loop into the code and it seemed to be better at 
> first, but the disconnects continue. See attachment. (Attachment 
> contains output during failure, loops many times, probably only the 
> first couple are of importance).
>
> As you can see from the  line (errno=112:Host is down), the headphones 
> are disconnected at this point, and I actually have to turn my 
> headphones back on.
>
> I should mention that I also use my bluetooth connection, 
> simultaneously, with my phone for internet access, and the a2dpd seems 
> to get upset whenever I try to grab data from the net. I figured that 
> my bluetooth chip should be able to handle this, as I thought that the 
> point of bluetooth was to be able to connect up to 7 devices to a 
> single chip, and the one I have (integrated into my laptop) says that 
> it is v2.0+EDR, which I figured would be plenty of bandwidth. I gave 
> the ppp connection a baud rate of 115200, and set the bitpool at 53 
> (had to hardcode, but that's another topic of discussion) which is i 
> think a baud rate of 763200. Now, when I had the bitpool set at 33, or 
> 475200 baud, the behavior was the same, and the headphones would get 
> kicked off frequently.
>
> So, I wonder, based on Brad's comment, if the "transfer=-1" is what 
> causes the shutoff of my headphones. And, if that's the case, where 
> should I go to change the value being written, and what should that 
> value be? If I change the "-1" to some junk data, will that collect on 
> the client side, and cause issues there, or could the headphone 
> crashes be because of collected junk data?
>
> Let me know what you guys think. And thanks for the help so far.
> -John
Sorry for the repeat message, but I still get disconnects while the 
bluetooth internet connection is not active, and I'm touching anything 
else either. So, basically, it's just a2dpd and amarok that are doing 
anything at all.

-John

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
