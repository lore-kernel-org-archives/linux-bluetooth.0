Return-Path: <bluez-users-bounces@lists.sourceforge.net>
Message-ID: <d89ddf300710151956p2f67e6edracc1dc88cca7be70@mail.gmail.com>
Date: Mon, 15 Oct 2007 20:56:02 -0600
From: "Brad Midgley" <bmidgley@gmail.com>
To: "BlueZ users" <bluez-users@lists.sourceforge.net>
In-Reply-To: <47140347.40409@gmail.com>
MIME-Version: 1.0
References: <47140347.40409@gmail.com>
Subject: Re: [Bluez-users] Alsa headset with MPlayer
Reply-To: BlueZ users <bluez-users@lists.sourceforge.net>
List-Id: BlueZ users <bluez-users.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-users>
List-Post: <mailto:bluez-users@lists.sourceforge.net>
List-Help: <mailto:bluez-users-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-users>,
	<mailto:bluez-users-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Sender: bluez-users-bounces@lists.sourceforge.net
Errors-To: bluez-users-bounces@lists.sourceforge.net

Hi

The patch is still valid, but you should be trying the audio service
in the current bluez-utils, especially if you have bugs to report,
suggestions, etc. http://wiki.bluez.org/wiki/HOWTO/AudioDevices

Brad

On 10/15/07, Advhertz <advhertz@gmail.com> wrote:
> Hi All,
> I've got workin' fine the BT headset with the last kernel 2.6.23 patched
> with sco-flowcontrol-v4.3.diff included in the plugz bluetooth alsa cvs
> repository and aplay/arecord, xmms, Rhythmbox and Skype too works fine.
> The problem now is mplayer.
>
> As I give the command " mplayer -ao alsa:device=headset " it stucks as here:
>
> Starting playback...
> A:   0.0 (00.0) of 226.0 (03:46.0) ??,?% 98%
>
> and it doesn't start to play.
>
> The headset string is the one I used in my $HOME/.asoundrc file as the
> following:
>
> pcm.headset {
>         type plug
>         slave {
>                 pcm "headsetBT"
>                 rate 8000
>                 format S16_LE
>                 channels 1
>         }
> }
>
> pcm.headsetBT {
>         @args [BDADDR TIMEOUT]
>
>         # The Bluetooth device address for target headset, used for
> Audio Gateway (PC) initiated connections
>         # Please note that this value is ignored when the connection is
> Headset initiated
>         @args.BDADDR {
>                 type string
>                 default "XX:XX:XX:XX:XX:XX"
>         }
>
>         # This value represents how long we will try to reach the
> headset, until we give up.
>         # Value is in milliseconds
>         @args.TIMEOUT {
>                 type integer
>                 default 6000
>         }
>
>         type        sco
>         bdaddr      $BDADDR
>         timeout     $TIMEOUT
> }
>
> ctl.headset {
>         type sco
> }
>
> Do anyone know anything about it ? MPlayer could work with the bt alsa
> headset, right? Maybe I wrong something?
>
> Let me know please.
>
> Thanks.
>
> Advhertz.
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc.
> Still grepping through log files to find problems?  Stop.
> Now Search log events and configuration files using AJAX and a browser.
> Download your FREE copy of Splunk now >> http://get.splunk.com/
> _______________________________________________
> Bluez-users mailing list
> Bluez-users@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-users
>

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >> http://get.splunk.com/
_______________________________________________
Bluez-users mailing list
Bluez-users@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-users
