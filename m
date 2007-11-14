Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <473B3D4C.2010103@moussaud.org>
Date: Wed, 14 Nov 2007 19:24:12 +0100
From: David MOUSSAUD <david@moussaud.org>
MIME-Version: 1.0
To: BlueZ users <bluez-users@lists.sourceforge.net>
References: <ecb5e6b70711041110l5e7a5a72tafac1954f6b927aa@mail.gmail.com>
In-Reply-To: <ecb5e6b70711041110l5e7a5a72tafac1954f6b927aa@mail.gmail.com>
Subject: Re: [Bluez-users] sco service with bluez3.19
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi,
To have it to work with VLC, just edit the~/.vlc/vlcrc file and add the =

following line:
alsadev=3Dbluetooth

(considering you have in  ~/.asoundrc pcm.bluetooth { ....} )

Emmanuel Wilhelm wrote:
> Hello,
>
> with Kubuntu Gutsy, I follow the howto AudioDevices
> http://wiki.bluez.org/wiki/HOWTO/AudioDevices
> Kubuntu installs by default bluez3.19, then I follow the =A7 for =

> bluez3.16 and newer.
>
> I have very good results for a2dp with amarok and Kaffeine (with vlc, =

> no access to the bluetooth device even with audio device list =

> renewed), but no sco service (arecord doesn't work, skype worked with =

> a bluez3.15 but doesn't work anymore):
>
> Does I have something else to do to get access to the sco service?
>
> Regards
> Emmanuel
> ------------------------------------------------------------------------
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc.
> Still grepping through log files to find problems?  Stop.
> Now Search log events and configuration files using AJAX and a browser.
> Download your FREE copy of Splunk now >> http://get.splunk.com/
> ------------------------------------------------------------------------
>
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>   =


-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
