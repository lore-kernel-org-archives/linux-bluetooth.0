Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <46320811.10802@jlab.org>
Date: Fri, 27 Apr 2007 10:26:25 -0400
From: Chris Carlin <carlin@jlab.org>
MIME-Version: 1.0
To: BlueZ development <bluez-devel@lists.sourceforge.net>
References: <463151D2.1040805@jlab.org> <4631762B.9060704@xmission.com>
In-Reply-To: <4631762B.9060704@xmission.com>
Subject: Re: [Bluez-devel] Plugz, a2dpd, and a2dpd2 strangeness
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Brad Midgley wrote:
>> With pcm_a2dpd2 I have jumpy, very sped up sound from the headphones and 
>> plenty of traffic through hcidump. Alsa redirect sounds about the same 
>> as the headphones, but the daemon gives the following errors:
> 
> I'm not following you here. What's the difference between using
> pcm_a2dpd2 and the "alsa redirect"? I didn't catch what "same as the
> headphones" was referring to either.

In retrospect I think I wasn't clear about pcm_a2dpd and pcm_a2dpd2. By 
those I meant the alsa plugins (libasound_module_pcm_a2dpd[2].so) as 
opposed to the similarly named daemon and NOT a definition in my .asoundrc.

The "alsa redirect" meant setting enableredirectalsa=1 in .a2dprc. I 
gather that this causes the a2dpd system to spit sound back out through 
alsa to speakers instead of through a bluetooth connection.

To restate more clearly (maybe) I'll give you a chart:

a2dpd plugin ("type a2dpd" in .asoundrc):
	bluetooth headphones (enableredirect=0 in .a2dprc):
		occasional chirps
		almost no traffic through hcidump
		flags=1 only gives info upon occurrance of chirps
	normal computer speakers (enableredirect=1):
		music sounds fine
a2dpd2 plugin ("type a2dpd2"):
	bluetooth headphones (enableredirect=0):
		garbled, sped up sound
		plenty of hcidump traffic
		flags=1 reports once a second or so
	normal computer speakers (enableredirect=1):
		garbled, sped up sound
		ring buffer full messages spew forth

An interesting thing to me is that enableredirect, if it does what I 
think it does, seems to show a non-bluetooth problem...

~Chris

-------------------------------------------------------------------------
This SF.net email is sponsored by DB2 Express
Download DB2 Express C - the FREE version of DB2 express and take
control of your XML. No limits. Just data. Click to get it now.
http://sourceforge.net/powerbar/db2/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
