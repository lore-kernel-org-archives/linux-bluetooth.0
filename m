Return-Path: <bluez-devel-bounces@lists.sourceforge.net>
Message-ID: <2d5a2c100708191902k599014cbo1e08c9c7a3febd45@mail.gmail.com>
Date: Sun, 19 Aug 2007 23:02:32 -0300
From: "Luiz Augusto von Dentz" <luiz.dentz@gmail.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
In-Reply-To: <46C875BA.90204@free.fr>
MIME-Version: 1.0
References: <46C875BA.90204@free.fr>
Subject: Re: [Bluez-devel] [PATCH] pcm_bluetooth : fix a2dp streaming
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="iso-8859-1"
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

Hi Fabian,

I got almost the same idea implemented in my git
(git://git.infradead.org/users/vudentz/bluez-utils.git). There is
alot of simplification you already did, but I consider the
bitrate as a2dp spec says. I also implement a circular
buffer for encoded sbc frames to be consumed by a
thread.

On 8/19/07, Fabien Chevalier <fabchevalier@free.fr> wrote:
> Johan & All,
>
> Following recent mailing list discussions, i decided to implement some
> of the ideas that have been suggested recently. :-)
>
> So i heavily modified the A2DP streaming part of the pcm plugin
>
> The user-visible features of this patch:
>    * much reduced latency (You should love this one Frederic)
>    * supports headsets that are unable to throttle the data flow and
>      that play too fast or drop packets or whatever (Marcel, could you
>      please confirm that fixes the issues you had with some headsets ?).
>
> This patch is fairly intrusive, and removes some code that i judjed
> useless now, like the bandwidth measurement stuff, and has greatly
> simplifyed transfer loop for avdtp (see comments in the code for the
> justifications)
>
> It brings in a thread that has for only reponsibility to increment the
> so called hardware pointer (which doesn't point to anything in our
> case), and notify the application trough writing in a pipe that some
> room is available (virtual room again), so that it could send more data.
>
> The attached file details the tests i've run to check i didn't break
> anything. All is conclusive except playing with XMMS that goes underrun
> for a reason i haven spotted yet. Apart from that aplay, mplayer,
> gstreamer are fine.
>
> I'm looking forward for any questions you have on the patch.
>
> Nest step would be to fix the SCO part of the plugin, but this one is
> looks harder as i think it will require tweaking the kernel SCO part.
>
> Regards,
>
> Fabien
>
> Bluetooth alsa a2dp non regression cookbook
> -------------------------------------------
>
> I) PCM test tool shipped with ALSA
>
> Setup:
> *Download the alsa-utils source for the binary that run on your machine
> *build the pcm executable in the test directory
>
> Run:
> ./pcm -c 2 -r 48000 -Dbluetooth -m write -b 10000
> ./pcm -c 2 -r 48000 -Dbluetooth -m write_and_poll -b 10000
> ./pcm -c 2 -r 48000 -Dbluetooth -m direct_write -b 10000
>
> Result:
> You should hear a clear sine in the headset.
> pcm process should not eat 100% cpu (check with top)
> Occasionnal sound drops are OK (due to quite short buffering of 10 ms)
>
> II) Play a file from XMMS
>
> III) Play file from totem
> Setup:
> * gconftool -t string -s /system/gstreamer/0.10/default/musicaudiosink "a=
lsasink device=3Dbluetooth"
>
> Run:
> Launch totem, then select a file for play
>
> III) PLay a file from mplayer
> mplayer -ao alsa:device=3Dbluetooth filetoplay.wav
>
> -------------------------------------------------------------------------
> This SF.net email is sponsored by: Splunk Inc.
> Still grepping through log files to find problems?  Stop.
> Now Search log events and configuration files using AJAX and a browser.
> Download your FREE copy of Splunk now >>  http://get.splunk.com/
> _______________________________________________
> Bluez-devel mailing list
> Bluez-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/bluez-devel
>
>
>


-- =

Luiz Augusto von Dentz
Engenheiro de Computa=E7=E3o

-------------------------------------------------------------------------
This SF.net email is sponsored by: Splunk Inc.
Still grepping through log files to find problems?  Stop.
Now Search log events and configuration files using AJAX and a browser.
Download your FREE copy of Splunk now >>  http://get.splunk.com/
_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel
