Return-Path: <bluez-devel-admin@lists.sourceforge.net>
Message-ID: <446B54AF.5040302@palmsource.com>
From: =?ISO-8859-1?Q?Fr=E9d=E9ric_DALLEAU?= <frederic.dalleau@palmsource.com>
MIME-Version: 1.0
To: bluez-devel@lists.sourceforge.net
Subject: Re: [Bluez-devel] A2DP and Alsa Plugin
References: <7A6DA545D7FDCC4B93DB651FDBC1EDDE46C2E7@eumonex01.palmsource.com> <4464C195.1020403@xmission.com>
In-Reply-To: <4464C195.1020403@xmission.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
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
Date: Wed, 17 May 2006 18:51:59 +0200

Hi brad,

>>	* How to select whether the application will output on a2dp or
>>speaker? Should this be application related or system related?
>>    
>>
>system. we need a way to change it while an app is outputing sound.
>  
>
It is not that simple with alsa, as I'm really unsure whether alsa can 
change output plugin at runtime unless the plugin reinject the sound 
into alsa itself? It's weird... Other than socket, what sort of ipc 
would allow mixing? I'm unsure a named pipe can do it. You need to 
create multiple pipes but how to choose one from the client app...

How about a daemon that uses gstreamer with one or more ipc gstreamer 
source, a mixmatrix, volume control (if not done by mixmatrix), (alsa 
sink or (sbcfilter and a2dp sink)) to finish...
An alsa plugin and/or a gstreamer ipc plugin would just send ipc to the 
daemon.

Now to be more specific, I still have some questions :

Why not sharing code between a2play and alsa-plugin?
There are some variables that are shared among instances 
(bufe,lenbufe,tsend,...) why are they globals? There is a snd_pcm_a2dp_t 
structure that would (IMHO) embed them very well. Is this alsa related 
limitation? This forbid using multiple headsets at a time...

Now that cvs works, how to propose patches? on the list? By creating a 
sf developper account?

Thanks
Frederic





-------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
