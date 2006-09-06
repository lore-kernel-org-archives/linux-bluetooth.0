Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <44FE95CE.1090502@palmsource.com>
Date: Wed, 06 Sep 2006 11:33:02 +0200
From: =?GB2312?B?RnKopmSopnJpYyBEQUxMRUFV?= <frederic.dalleau@palmsource.com>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <554C5F4C5BA7384EB2B412FD46A3BAD10135633A@pdsmsx411.ccr.corp.intel.com>
	<44FE42C7.7030100@xmission.com>
In-Reply-To: <44FE42C7.7030100@xmission.com>
Subject: Re: [Bluez-devel] Big patch to a2dpd
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: multipart/mixed; boundary="===============1813906357=="
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

--===============1813906357==
Content-Type: text/plain; charset=GB2312
Content-Transfer-Encoding: 7bit

Hi,

> Lea
>
>   
>> Yes. I prefer modifying alsa_transfer_raw(), which makes the framework logic consistent. How do you think about it? 
>>     
>
> I'm not familiar with this new stuff, but it seems that the return
> values were commented out for some reason and maybe forgotten. If
> Frederic has no problems with the change to alsa_transfer_raw, I'll do
> it that way.
>   

Hi Brad and Lea,
No it's not forgotten : what I wanted is to restart audio on errors. I
had some failures when trying to recover : when pausing a stream in
xmms, an underrun occurs as the alsa device is not closed.
However, I didn't investigate the xrun_recovery return value.
Lea's patch is interesting but it miss something : the xrun_recovery
will ALWAYS return 0 if fed with EPIPE or ESIGPIPE, whether the recovery
succeed or not.
The cleanest is to keep Lea's patch but remove the two "return 0;" calls
in order to "return err;" at the end of the func.

The modification to a2dpd.c should not be done.

See the following :

static int xrun_recovery(snd_pcm_t * handle, int err)
{
if (err == -EPIPE) { /* under-run */
err = snd_pcm_prepare(handle);
if (err < 0)
printf("Can't recovery from underrun, prepare failed: %s\n",
snd_strerror(err));
return 0; // ------------------------ Remove this line to return err at
the end of the func
} else if (err == -ESTRPIPE) {
while ((err = snd_pcm_resume(handle)) == -EAGAIN)
sleep(1); /* wait until the suspend flag is released */
if (err < 0) {
err = snd_pcm_prepare(handle);
if (err < 0)
printf("Can't recovery from suspend, prepare failed: %s\n",
snd_strerror(err));
}
return 0;// ------------------------ Remove this line to return err at
the end of the func
}
return err;
}





--===============1813906357==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
--===============1813906357==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

--===============1813906357==--
