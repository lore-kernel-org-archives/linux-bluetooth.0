Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="----_=_NextPart_001_01C8B655.C36EF452"
Date: Thu, 15 May 2008 14:34:43 +0800
Message-ID: <094BCE01AFBE9646AF220B0B3F367AAB03105FE2@pdsmsx413.ccr.corp.intel.com>
In-Reply-To: <029E5BE7F699594398CA44E3DDF5544401DD1643@swsmsx413.ger.corp.intel.com>
References: <094BCE01AFBE9646AF220B0B3F367AAB03105C80@pdsmsx413.ccr.corp.intel.com>
	<029E5BE7F699594398CA44E3DDF5544401DD1643@swsmsx413.ger.corp.intel.com>
From: "Zhao, Halley" <halley.zhao@intel.com>
To: "BlueZ development" <bluez-devel@lists.sourceforge.net>
Cc: "Wong, James Sing Toh" <james.sing.toh.wong@intel.com>,
	"Holtmann,  Marcel" <marcel.holtmann@intel.com>,
	"Guo, Young" <young.guo@intel.com>
Subject: Re: [Bluez-devel] An Issue with A2dpd and some suggestions
Reply-To: BlueZ development <bluez-devel@lists.sourceforge.net>
List-Id: BlueZ development <bluez-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=bluez-devel>
List-Post: <mailto:bluez-devel@lists.sourceforge.net>
List-Help: <mailto:bluez-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/bluez-devel>,
	<mailto:bluez-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: bluez-devel-bounces@lists.sourceforge.net
Errors-To: bluez-devel-bounces@lists.sourceforge.net

------_=_NextPart_001_01C8B655.C36EF452
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: quoted-printable

=A1=A1=A1=A1I know little of ALSA or Bluez, so I don't know the detail =
inside.
=A1=A1=A1=A11. attached log files:
=A1=A1=A1=A1   Blue-startup.log: the log information when "hcid -d -n" =
start to run
=A1=A1=A1=A1   Bluez-play.log: during a helix based player playback an =
audio stream, the log information from hcid.
=A1=A1=A1=A1
=A1=A1=A1=A12. ALSA api=20
=A1=A1=A1=A1 snd_pcm_hw_params() --> snd_pcm_prepare() --> =
pcm->fast_ops->prepare(pcm->fast_op_arg)
=A1=A1=A1=A1I guess it will call to (from printf log, it does)
=A1=A1=A1=A1File: audio/pcm_bluetooth.c=20
=A1=A1=A1=A1Function: bluetooth_prepare()
=A1=A1=A1=A1And in this function, it will use the return value from =
write(data->pipefd[1],&c,1) as its (bluetooth_prepare) return value.---- =
I think the positive return value "1" was create here;=20
=A1=A1=A1=A1but I don't know whether there should be some place to =
translate this value to a valid return value of ALSA API. And I also =
don't what "1" is valid return value from the write() function.
=A1=A1=A1=A1
=A1=A1=A1=A1
=A1=A1=A1=A1BR
=A1=A1=A1=A1
=A1=A1=A1=A1
=A1=A1=A1=A1
=A1=A1=A1=A1>-----Original Message-----
=A1=A1=A1=A1>From: Holtmann, Marcel
=A1=A1=A1=A1>Sent: 2008=C4=EA5=D4=C214=C8=D5 21:08
=A1=A1=A1=A1>To: Zhao, Halley; Wong, James Sing Toh
=A1=A1=A1=A1>Cc: Guo, Young
=A1=A1=A1=A1>Subject: RE: An Issue with A2dpd and some suggestions
=A1=A1=A1=A1>
=A1=A1=A1=A1>Hi Halley,
=A1=A1=A1=A1>
=A1=A1=A1=A1>does a call to snd_pcm_hw_params() gets re-directed to the =
Bluetooth plugin
=A1=A1=A1=A1>from the ALSA API? What is the actual call chain for it.
=A1=A1=A1=A1>
=A1=A1=A1=A1>Personally I would say this is an ALSA problem, but it =
could also be a BlueZ
=A1=A1=A1=A1>problem since I must admit the ALSA plugins APIs are not =
really clear and
=A1=A1=A1=A1>the possibility that we made a mistake is quite high.
=A1=A1=A1=A1>
=A1=A1=A1=A1>Please run "hcid -n -d" and then copy the output from your =
application
=A1=A1=A1=A1>calling sndP_pcm_hw_params() so we see where inside the =
BlueZ code we are
=A1=A1=A1=A1>actually. My wild guess is that if it is a BlueZ issue, =
then this will be
=A1=A1=A1=A1>hidden somewhere non obvious. Please put this result on the =
BlueZ mailing
=A1=A1=A1=A1>list so Luiz can have a look at it, too.
=A1=A1=A1=A1>
=A1=A1=A1=A1>Regards
=A1=A1=A1=A1>
=A1=A1=A1=A1>Marcel
=A1=A1=A1=A1>
=A1=A1=A1=A1>>-----Original Message-----
=A1=A1=A1=A1>>From: Zhao, Halley
=A1=A1=A1=A1>>Sent: Wednesday, May 14, 2008 1:34 AM
=A1=A1=A1=A1>>To: Holtmann, Marcel; Wong, James Sing Toh
=A1=A1=A1=A1>>Cc: Guo, Young; Zhao, Halley
=A1=A1=A1=A1>>Subject: FW: An Issue with A2dpd and some suggestions
=A1=A1=A1=A1>>
=A1=A1=A1=A1>>=A1=A1=A1=A1Hi Marcel:
=A1=A1=A1=A1>>=A1=A1=A1=A1With your (and bluez community) help, finally =
I installed bluez-3.31
=A1=A1=A1=A1>on
=A1=A1=A1=A1>>my desktop. Great thanks.
=A1=A1=A1=A1>>
=A1=A1=A1=A1>>=A1=A1=A1=A1But I still have the issue that =
snd_pcm_hw_params() give a return value
=A1=A1=A1=A1>>of "1" which is undefined meaning for this API. After I =
hack that return
=A1=A1=A1=A1>>value to 0 (success). A helix based player (RP4MID) could =
work well on this
=A1=A1=A1=A1>>package.
=A1=A1=A1=A1>>
=A1=A1=A1=A1>>=A1=A1=A1=A1But I still don't know where the root cause =
is, James is more cared
=A1=A1=A1=A1>about
=A1=A1=A1=A1>>it.
=A1=A1=A1=A1>>
=A1=A1=A1=A1>>=A1=A1=A1=A1Thanks BR.
=A1=A1=A1=A1>>=A1=A1=A1=A1"
=A1=A1=A1=A1>http://www.alsa-project.org/alsa-doc/alsa-lib/group___p_c_m.=
html
=A1=A1=A1=A1>>=A1=A1=A1=A1        int snd_pcm_hw_params  ()
=A1=A1=A1=A1>>=A1=A1=A1=A1        Returns:
=A1=A1=A1=A1>>=A1=A1=A1=A1            0 on success otherwise a negative =
error code
=A1=A1=A1=A1>>=A1=A1=A1=A1"
=A1=A1=A1=A1>>
=A1=A1=A1=A1>>
=A1=A1=A1=A1>>=A1=A1=A1=A1-----Original Message-----
=A1=A1=A1=A1>>From: Holtmann, Marcel
=A1=A1=A1=A1>>Sent: 2008=C4=EA5=D4=C29=C8=D5 21:09
=A1=A1=A1=A1>>To: Zhao, Halley
=A1=A1=A1=A1>>Cc: Guo, Young; Zheng, Huan; Tang, Feng; Lynch, Rusty
=A1=A1=A1=A1>>Subject: RE: An Issue with A2dpd and some suggestions
=A1=A1=A1=A1>>
=A1=A1=A1=A1>>=A1=A1=A1=A1Hi Halley,
=A1=A1=A1=A1>>
=A1=A1=A1=A1>>=A1=A1=A1=A1can you please mail this bug report to the =
bluez-devel mailing list.
=A1=A1=A1=A1>Then
=A1=A1=A1=A1>>we have more experts looking at it. There is also a avinfo =
tool inside the
=A1=A1=A1=A1>>bluez-utils packages that allows you to discover details =
on the A2DP
=A1=A1=A1=A1>>features supported by your headset.
=A1=A1=A1=A1>>
=A1=A1=A1=A1>>
=A1=A1=A1=A1>>=A1=A1=A1=A1Additionally you should check that the ALSA or =
GStreamer plugins are
=A1=A1=A1=A1>>installed at the right location. Sometimes it happens that =
the wrong one
=A1=A1=A1=A1>is
=A1=A1=A1=A1>>used and that makes it incompatible.
=A1=A1=A1=A1>>
=A1=A1=A1=A1>>=A1=A1=A1=A1Regards
=A1=A1=A1=A1>>
=A1=A1=A1=A1>>=A1=A1=A1=A1Marcel
=A1=A1=A1=A1>>
=A1=A1=A1=A1>>=A1=A1=A1=A1>-----Original Message-----
=A1=A1=A1=A1>>=A1=A1=A1=A1>From: Zhao, Halley
=A1=A1=A1=A1>>=A1=A1=A1=A1>Sent: Friday, May 09, 2008 3:23 AM
=A1=A1=A1=A1>>=A1=A1=A1=A1>To: Holtmann, Marcel
=A1=A1=A1=A1>>=A1=A1=A1=A1>Cc: Guo, Young; Zheng, Huan; Tang, Feng; =
Lynch, Rusty
=A1=A1=A1=A1>>=A1=A1=A1=A1>Subject: RE: An Issue with A2dpd and some =
suggestions
=A1=A1=A1=A1>>=A1=A1=A1=A1>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1Hi Marcel:
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1My Bluetooth earphone is Motorola =
HT820.
=A1=A1=A1=A1>>=A1=A1=A1=A1>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A11. When I try to use bluez-utils =
3.31 on my desktop (Ubuntu7.10),
=A1=A1=A1=A1>>there
=A1=A1=A1=A1>>=A1=A1=A1=A1>are some issues: (but there is no such issue =
when I use 3.19 version
=A1=A1=A1=A1>on
=A1=A1=A1=A1>>=A1=A1=A1=A1>this same platform). Should I update some =
other package besides bluez-
=A1=A1=A1=A1>>utils
=A1=A1=A1=A1>>=A1=A1=A1=A1>and bluez-libs?
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1"
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1halley@azhao2ubtg2:~$ aplay
=A1=A1=A1=A1>/home/halley/media/audio/Track27.wav
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1ALSA lib =
pcm_bluetooth.c:1501:(audioservice_recv) Error
=A1=A1=A1=A1>receiving data
=A1=A1=A1=A1>>=A1=A1=A1=A1>from audio service: Success(0)
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1ALSA lib =
pcm_bluetooth.c:1517:(audioservice_expect) Bogus
=A1=A1=A1=A1>message
=A1=A1=A1=A1>>=A1=A1=A1=A1>BT_GETCAPABILITIES_REQ received while =
BT_GETCAPABILITIES_RSP was
=A1=A1=A1=A1>>expected
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1aplay: main:545: audio open =
error: Invalid argument
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1"
=A1=A1=A1=A1>>=A1=A1=A1=A1>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A12. When I use bluez-utils 3.19 =
version, application calls
=A1=A1=A1=A1>>=A1=A1=A1=A1>snd_pcm_hw_params() sometimes will got return =
value "1". (The
=A1=A1=A1=A1>function
=A1=A1=A1=A1>>=A1=A1=A1=A1>description says it will be 0 for success and =
negative number for
=A1=A1=A1=A1>>failure).
=A1=A1=A1=A1>>=A1=A1=A1=A1>The positive value makes me puzzled.
=A1=A1=A1=A1>>=A1=A1=A1=A1>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1    /* Apply parameters */
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1	err =3D =
snd_pcm_hw_params(m_pAlsaPCMHandle, hwparams);
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1	if (err < 0)
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1    {
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1        HXLOGL1 ( HXLOG_ADEV, =
"snd_pcm_hw_params: %s",
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1                  =
snd_strerror(err));
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1        m_wLastError =3D =
RA_AOE_NOTENABLED;
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1	}
=A1=A1=A1=A1>>=A1=A1=A1=A1>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1    /* read buffer & period sizes =
*/
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1    snd_pcm_uframes_t buffer_size =
=3D 0;
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1    snd_pcm_uframes_t period_size =
=3D 0;
=A1=A1=A1=A1>>=A1=A1=A1=A1>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1    if (err =3D=3D 0)
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1    {
=A1=A1=A1=A1>>=A1=A1=A1=A1>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>-----Original Message-----
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>From: Holtmann, Marcel
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>Sent: 2008=C4=EA4=D4=C229=C8=D5 =
19:01
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>To: Zhao, Halley
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>Cc: Li, Frank; Guo, Young; =
Zheng, Huan; Tang, Feng; Lynch, Rusty
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>Subject: RE: An Issue with A2dpd =
and some suggestions
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>Hi Halley,
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>if you read the ChangeLog file =
it clearly states that you need
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>bluez-libs-3.30 to use =
bluez-utils-3.30.
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>You can find bluez-utils-3.28 at =
the same position you
=A1=A1=A1=A1>downloaded
=A1=A1=A1=A1>>3.30
=A1=A1=A1=A1>>=A1=A1=A1=A1>from.
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>However there is no link it, but =
the packages are still
=A1=A1=A1=A1>available.
=A1=A1=A1=A1>>=A1=A1=A1=A1>However
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>in case of 3.28 you need at =
least bluez-libs-3.28 to match up
=A1=A1=A1=A1>with
=A1=A1=A1=A1>>it.
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>Regards
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>Marcel
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>-----Original Message-----
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>From: Zhao, Halley
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>Sent: Tue 4/29/2008 2:12 AM
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>To: Holtmann, Marcel
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>Cc: Li, Frank; Guo, Young; =
Zheng, Huan; Tang, Feng; Lynch, Rusty
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>Subject: RE: An Issue with A2dpd =
and some suggestions
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??Hi Marcel:
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??When I tried bluez-utils-3.30, =
I was block by error:
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??"hciconfig.c:(.text+0x37ee): =
undefined reference to
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>`hci_write_inquiry_transmit_power=
_level'
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??hciconfig.c:(.text+0x3823): =
undefined reference to
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>`hci_read_inquiry_transmit_power_=
level'
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??"
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??Where could I get 3.28 version =
?
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>-----Original Message-----
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>From: Holtmann, Marcel
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>Sent: 2008?4?29? 15:46
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>To: Zhao, Halley
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>Cc: Li, Frank; Guo, Young; =
Zheng, Huan; Tang, Feng; Lynch,
=A1=A1=A1=A1>Rusty
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>Subject: RE: An Issue with =
A2dpd and some suggestions
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>Hi Halley,
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>the latest version of =
bluez-utils is 3.30 and I am just about
=A1=A1=A1=A1>to
=A1=A1=A1=A1>>=A1=A1=A1=A1>release
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>3.31. When you talk about =
3.19, then you talk about a release
=A1=A1=A1=A1>that
=A1=A1=A1=A1>>is
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>over
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>7 month old. In some cases =
that might be fine, but with a topic
=A1=A1=A1=A1>>like
=A1=A1=A1=A1>>=A1=A1=A1=A1>A2DP
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>it is not. Simply download =
bluez-utils-3.30 and look at the
=A1=A1=A1=A1>>ChangeLog
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>file.
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>It has the highlights of =
changes and you will see a lot of
=A1=A1=A1=A1>them in
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>direction
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>of A2DP. If you stick with =
3.19 you might get it working, but
=A1=A1=A1=A1>you
=A1=A1=A1=A1>>=A1=A1=A1=A1>might
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>also
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>discover all the fixed bugs =
over and over again.
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>You can clone a copy from the =
git://git.infradead.org/bluez-
=A1=A1=A1=A1>>utils.git
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>mirror and then run "gitk =
audio" to see only the audio service
=A1=A1=A1=A1>>(A2DP
=A1=A1=A1=A1>>=A1=A1=A1=A1>and
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>Headset) related changes and =
then judge for yourself.
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>With Ubuntu Hardy you get at =
least 3.26 and even that is
=A1=A1=A1=A1>already
=A1=A1=A1=A1>>=A1=A1=A1=A1>pretty
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>old.
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>The best choice might be too =
look at some updates packages
=A1=A1=A1=A1>from
=A1=A1=A1=A1>>=A1=A1=A1=A1>Debian,
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>because I remember that they =
already packaged 3.30 and my
=A1=A1=A1=A1>advise
=A1=A1=A1=A1>>=A1=A1=A1=A1>would
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>be
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>to wait until the end of this =
week when I actually release
=A1=A1=A1=A1>3.31
=A1=A1=A1=A1>>since
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>that
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>has a lot of fixes in it.
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>If you don't wanna wait, the =
best release would be currently
=A1=A1=A1=A1>the
=A1=A1=A1=A1>>=A1=A1=A1=A1>3.28,
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>because that was before we =
introduced the new API. Once 3.31
=A1=A1=A1=A1>is
=A1=A1=A1=A1>>out
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>everything is back to normal =
again. However with 3.28 the
=A1=A1=A1=A1>services
=A1=A1=A1=A1>>=A1=A1=A1=A1>are
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>in
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>a separate process and with =
3.31 everything will be a plugin
=A1=A1=A1=A1>(just
=A1=A1=A1=A1>>=A1=A1=A1=A1>for
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>the
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>technical clarification).
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>Regards
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>Marcel
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>-----Original Message-----
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>From: Zhao, Halley
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>Sent: Mon 4/28/2008 10:54 PM
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>To: Holtmann, Marcel
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>Cc: Li, Frank; Guo, Young; =
Zheng, Huan; Zhao, Halley; Tang,
=A1=A1=A1=A1>Feng;
=A1=A1=A1=A1>>=A1=A1=A1=A1>Lynch,
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>Rusty
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>Subject: RE: An Issue with =
A2dpd and some suggestions
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??Hi Marcel:
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??Our OS is Ubuntu based, and =
there is bluez-utils
=A1=A1=A1=A1>(3.19-0ubuntu3)
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>installed.
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??The package information =
gives us the link
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>http://bluez.sourceforge.net,
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>and it is same to =
http://www.bluez.org/, do you think the 3.19
=A1=A1=A1=A1>>=A1=A1=A1=A1>version
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>is
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>ok for us?
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??Is it correct?
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??If not, how could we remove =
the "plugz" and install
=A1=A1=A1=A1>bluez-utils?
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??Must we start from the =
source package from
=A1=A1=A1=A1>>http://www.bluez.org/?
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>-----Original Message-----
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>From: Holtmann, Marcel
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>Sent: 2008?4?28? 17:53
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>To: Zheng, Huan
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>Cc: Zhao, Halley; Li, =
Frank; Guo, Young
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>Subject: RE: An Issue with =
A2dpd and some suggestions
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>Hi Huan,
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>there is a simple answer =
to this. You are using the plugz
=A1=A1=A1=A1>code
=A1=A1=A1=A1>>and
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>that
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>is
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>wrong. This code is =
outdated and deprecated. The
=A1=A1=A1=A1>bluez-utils
=A1=A1=A1=A1>>=A1=A1=A1=A1>packages
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>contains the audio service =
(which is now actually a plugin)
=A1=A1=A1=A1>and
=A1=A1=A1=A1>>=A1=A1=A1=A1>has
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>plugins
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>for ALSA and GStreamer =
integration. This audio service
=A1=A1=A1=A1>fully
=A1=A1=A1=A1>>=A1=A1=A1=A1>supports
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>A2DP
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>and is widely tested. =
Check wiki.bluez.org for more
=A1=A1=A1=A1>details on
=A1=A1=A1=A1>>how
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>to
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>setup
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>your .asoundrc for testing =
it.
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>Regards
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>Marcel
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>-----Original Message-----
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>From: Zheng, Huan
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>Sent: Sun 4/27/2008 10:11 =
PM
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>To: Holtmann, Marcel
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>Cc: Zhao, Halley; Li, =
Frank; Guo, Young; Zheng, Huan
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>Subject: An Issue with =
A2dpd and some suggestions
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>Hi, Marcel
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>I'm an engineer from OTC =
PRC, I'm currently working
=A1=A1=A1=A1>moblin.
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>I encountered an issue =
when using Bluetooth alsa on Crown
=A1=A1=A1=A1>>Beach,
=A1=A1=A1=A1>>=A1=A1=A1=A1>and
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>I
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>have
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>located the code where =
cause the issue, it may be a
=A1=A1=A1=A1>potential
=A1=A1=A1=A1>>bug,
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>but
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>I'm
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>not sure. Since you are =
the expert on Bluetooth-alsa, very
=A1=A1=A1=A1>much
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>appreciate
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>your opinions.
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>Symptom:
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>After finished playing one =
song, then opening another song
=A1=A1=A1=A1>will
=A1=A1=A1=A1>>=A1=A1=A1=A1>hear
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>nothing,
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>and finally hang.
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>Investigation:
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>Code hang on =
snd_pcm_prepare, which finally goes into
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>a2dp_prepare(snd_pcm_ioplug=
_t * io)  inside
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>plugz/alsa-plugin/a2dpd/pcm=
_a2dpd.c
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>Code hangs on
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>while(poll_accept(a2dp->sk,=
 0)) {
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>                   =
transfer =3D recv_socket(a2dp->sk,
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>&GetPointerResp,
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>sizeof(GetPointerResp));
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>         }
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>At this place, poll_accept =
always return true, but inside
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>recv_socket,
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>recv
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>call report errono =
104(connection reset by peer). This
=A1=A1=A1=A1>becomes
=A1=A1=A1=A1>>an
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>infinite
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>loop.
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>Suggestions:
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>I'm thinking that is it =
possible to add functionality into
=A1=A1=A1=A1>>=A1=A1=A1=A1>poll_accept
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>to
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>judge whether connection =
has been reset? If find
=A1=A1=A1=A1>connection has
=A1=A1=A1=A1>>=A1=A1=A1=A1>been
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>reset,
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>then do some recovery and =
return 0 to let the while loop
=A1=A1=A1=A1>end.
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>There is a new bit since =
2.6.17, maybe this will be helpful
=A1=A1=A1=A1>to
=A1=A1=A1=A1>>=A1=A1=A1=A1>judge
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>whether
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>connection has been reset =
when using poll.
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>POLLRDHUP " (since Linux =
2.6.17)"
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>Stream socket peer closed =
connection, or shut down writing
=A1=A1=A1=A1>half
=A1=A1=A1=A1>>of
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>connection. The =
_GNU_SOURCE feature test macro must be
=A1=A1=A1=A1>defined
=A1=A1=A1=A1>>in
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>order
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>to
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>obtain this definition.
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>Could you please share =
your opinions on this?
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>Thanks a lot!
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>For your convenience, I =
attached the code below:
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>int poll_accept(int =
sockfd, int timeout)
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>{
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>         int result =3D 0;
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>         int ipoll =3D -1;
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>         struct pollfd =
pollfds[1];
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>         pollfds[0].fd =3D =
sockfd;
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>         pollfds[0].events =
=3D POLLIN;
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>         =
pollfds[0].revents =3D 0;
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>         ipoll =3D =
poll(pollfds, (nfds_t)1, timeout);
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>         if((ipoll>0) && =
(pollfds[0].revents & POLLIN))
=A1=A1=A1=A1>{
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>                   result =
=3D 1;
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>         } else =
if(ipoll=3D=3D0) {
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>                   errno =
=3D EAGAIN;
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>         }
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>         return result;
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>}
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>ssize_t recv_socket(int =
sockfd, void* buffer, size_t
=A1=A1=A1=A1>size)
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>{
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>        ssize_t received =
=3D 0;
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>        =
while((buffer!=3D0) && (received<(ssize_t)size))
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>        {
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>                ssize_t =
result =3D recv(sockfd,
=A1=A1=A1=A1>buffer+received,
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>size-received, =
MSG_NOSIGNAL);
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>                =
if(result>0)
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>                {
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>                        =
received +=3D result;
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>                        =
if(result !=3D (ssize_t)size)
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>                           =
     DBG("split frame
=A1=A1=A1=A1>received
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>(%d/%d)",
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>(int)result, (int)size);
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>                }
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>                else
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>                {
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>                        =
received=3Dresult;
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>                        =
break;
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>                }
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>        }
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>        return received;
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>}
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>Best Regards, Zheng, =
Huan(ZBT)
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>OTC/SSD/SSG
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>Intel Aisa-Pacific =
Research & Developement Ltd
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>Tel: 021-6116 6435
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>Inet: 8821 6435
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>Cub: 3W035
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??>
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??>??
=A1=A1=A1=A1>>=A1=A1=A1=A1>=A1=A1=A1=A1>??
=A1=A1=A1=A1>>=A1=A1=A1=A1>

------_=_NextPart_001_01C8B655.C36EF452
Content-Type: application/octet-stream; name="bluez-play.log"
Content-Transfer-Encoding: base64
Content-Description: bluez-play.log
Content-Disposition: attachment; filename="bluez-play.log"

aGNpZFs1NzUzXTogQWNjZXB0ZWQgbmV3IGNsaWVudCBjb25uZWN0aW9uIG9uIHVuaXggc29ja2V0
IChmZD0xMikKaGNpZFs1NzUzXTogQXVkaW8gQVBJOiByZWNlaXZlZCBCVF9HRVRDQVBBQklMSVRJ
RVNfUkVRCmhjaWRbNTc1M106IGF2ZHRwX3JlZigweDgwOGNhNjApOiByZWY9MgpoY2lkWzU3NTNd
OiBsaW5rX2tleV9yZXF1ZXN0IChzYmE9MDA6MTE6Njc6NTI6Mjk6MjMsIGRiYT0wMDowNzpBNDpC
NTpEODo5RSkKaGNpZFs1NzUzXTogQVZEVFA6IGNvbm5lY3RlZCBzaWduYWxpbmcgY2hhbm5lbCB0
byAwMDowNzpBNDpCNTpEODo5RQpoY2lkWzU3NTNdOiBzZXNzaW9uX2NiCmhjaWRbNTc1M106IERJ
U0NPVkVSIHJlcXVlc3Qgc3VjY2VlZGVkCmhjaWRbNTc1M106IHNlaWQgMSB0eXBlIDEgbWVkaWEg
MCBpbiB1c2UgMApoY2lkWzU3NTNdOiBzZXNzaW9uX2NiCmhjaWRbNTc1M106IEdFVF9DQVBBQklM
SVRJRVMgcmVxdWVzdCBzdWNjZWVkZWQKaGNpZFs1NzUzXTogc2VpZCAxIHR5cGUgMSBtZWRpYSAw
CmhjaWRbNTc1M106IEF1ZGlvIEFQSTogc2VuZGluZyBCVF9HRVRDQVBBQklMSVRJRVNfUlNQCmhj
aWRbNTc1M106IFVuaXggY2xpZW50IGRpc2Nvbm5lY3RlZCAoZmQ9MTIpCmhjaWRbNTc1M106IGF2
ZHRwX3VucmVmKDB4ODA4Y2E2MCk6IHJlZj0xCmhjaWRbNTc1M106IEFjY2VwdGVkIG5ldyBjbGll
bnQgY29ubmVjdGlvbiBvbiB1bml4IHNvY2tldCAoZmQ9MTIpCmhjaWRbNTc1M106IEF1ZGlvIEFQ
STogcmVjZWl2ZWQgQlRfR0VUQ0FQQUJJTElUSUVTX1JFUQpoY2lkWzU3NTNdOiBhdmR0cF9yZWYo
MHg4MDhjYTYwKTogcmVmPTIKaGNpZFs1NzUzXTogQXVkaW8gQVBJOiBzZW5kaW5nIEJUX0dFVENB
UEFCSUxJVElFU19SU1AKaGNpZFs1NzUzXTogQXVkaW8gQVBJOiByZWNlaXZlZCBCVF9TRVRDT05G
SUdVUkFUSU9OX1JFUQpoY2lkWzU3NTNdOiBjb25maWcgYTJkcCAtIGRldmljZSA9IDAwOjA3OkE0
OkI1OkQ4OjlFIGFjY2Vzc19tb2RlID0gMgpoY2lkWzU3NTNdOiBjb2RlYyBzYmMgLSBmcmVxdWVu
Y3kgPSAyIGNoYW5uZWxfbW9kZSA9IDEgYWxsb2NhdGlvbiA9IDEgc3ViYmFuZHMgPSAxIGJsb2Nr
cyA9IDEgYml0cG9vbCA9IDMzCmhjaWRbNTc1M106IGEyZHBfc291cmNlX2NvbmZpZzogc2VsZWN0
ZWQgU0VQIDB4ODA5NjFkOApoY2lkWzU3NTNdOiBhdmR0cF9yZWYoMHg4MDhjYTYwKTogcmVmPTMK
aGNpZFs1NzUzXTogc2V0dXBfcmVmKDB4ODA5N2EyMCk6IHJlZj0xCmhjaWRbNTc1M106IGF2ZHRw
X3NldF9jb25maWd1cmF0aW9uKDB4ODA4Y2E2MCk6IGludF9zZWlkPTEsIGFjcF9zZWlkPTEKaGNp
ZFs1NzUzXTogc2Vzc2lvbl9jYgpoY2lkWzU3NTNdOiBTRVRfQ09ORklHVVJBVElPTiByZXF1ZXN0
IHN1Y2NlZWRlZApoY2lkWzU3NTNdOiBTb3VyY2UgMHg4MDk2MWQ4OiBTZXRfQ29uZmlndXJhdGlv
bl9DZm0KaGNpZFs1NzUzXTogYXZkdHBfcmVmKDB4ODA4Y2E2MCk6IHJlZj00CmhjaWRbNTc1M106
IHN0cmVhbSBzdGF0ZSBjaGFuZ2VkOiBJRExFIC0+IENPTkZJR1VSRUQKaGNpZFs1NzUzXTogc2Vz
c2lvbl9jYgpoY2lkWzU3NTNdOiBPUEVOIHJlcXVlc3Qgc3VjY2VlZGVkCmhjaWRbNTc1M106IHN0
cmVhbSBzdGF0ZSBjaGFuZ2VkOiBDT05GSUdVUkVEIC0+IE9QRU4KaGNpZFs1NzUzXTogQVZEVFA6
IGNvbm5lY3RlZCB0cmFuc3BvcnQgY2hhbm5lbCB0byAwMDowNzpBNDpCNTpEODo5RQpoY2lkWzU3
NTNdOiBTb3VyY2UgMHg4MDk2MWQ4OiBPcGVuX0NmbQpoY2lkWzU3NTNdOiBzZXR1cF9yZWYoMHg4
MDk3YTIwKTogcmVmPTIKaGNpZFs1NzUzXTogU0VQIDB4ODA5NjFkOCBsb2NrZWQKaGNpZFs1NzUz
XTogQXVkaW8gQVBJOiBzZW5kaW5nIEJUX1NFVENPTkZJR1VSQVRJT05fUlNQCmhjaWRbNTc1M106
IHNldHVwX3VucmVmKDB4ODA5N2EyMCk6IHJlZj0xCmhjaWRbNTc1M106IHNldHVwX3VucmVmKDB4
ODA5N2EyMCk6IHJlZj0wCmhjaWRbNTc1M106IHNldHVwX2ZyZWUoMHg4MDk3YTIwKQpoY2lkWzU3
NTNdOiBhdmR0cF91bnJlZigweDgwOGNhNjApOiByZWY9MwpoY2lkWzU3NTNdOiBBdWRpbyBBUEk6
IHJlY2VpdmVkIEJUX1NUUkVBTVNUQVJUX1JFUQpoY2lkWzU3NTNdOiBhdmR0cF9yZWYoMHg4MDhj
YTYwKTogcmVmPTQKaGNpZFs1NzUzXTogc2V0dXBfcmVmKDB4ODA5N2EyMCk6IHJlZj0xCmhjaWRb
NTc1M106IHNlc3Npb25fY2IKaGNpZFs1NzUzXTogU1RBUlQgcmVxdWVzdCBzdWNjZWVkZWQKaGNp
ZFs1NzUzXTogU291cmNlIDB4ODA5NjFkODogU3RhcnRfQ2ZtCmhjaWRbNTc1M106IHNldHVwX3Jl
ZigweDgwOTdhMjApOiByZWY9MgpoY2lkWzU3NTNdOiBBdWRpbyBBUEk6IHNlbmRpbmcgQlRfU1RS
RUFNU1RBUlRfUlNQCmhjaWRbNTc1M106IEF1ZGlvIEFQSTogc2VuZGluZyBCVF9TVFJFQU1GRF9J
TkQKaGNpZFs1NzUzXTogc2V0dXBfdW5yZWYoMHg4MDk3YTIwKTogcmVmPTEKaGNpZFs1NzUzXTog
c2V0dXBfdW5yZWYoMHg4MDk3YTIwKTogcmVmPTAKaGNpZFs1NzUzXTogc2V0dXBfZnJlZSgweDgw
OTdhMjApCmhjaWRbNTc1M106IGF2ZHRwX3VucmVmKDB4ODA4Y2E2MCk6IHJlZj0zCmhjaWRbNTc1
M106IHN0cmVhbSBzdGF0ZSBjaGFuZ2VkOiBPUEVOIC0+IFNUUkVBTUlORwpoY2lkWzU3NTNdOiBB
dWRpbyBBUEk6IHJlY2VpdmVkIEJUX1NUUkVBTVNUQVJUX1JFUQpoY2lkWzU3NTNdOiBhdmR0cF9y
ZWYoMHg4MDhjYTYwKTogcmVmPTQKaGNpZFs1NzUzXTogc2V0dXBfcmVmKDB4ODA5N2EyMCk6IHJl
Zj0xCmhjaWRbNTc1M106IHNldHVwX3JlZigweDgwOTdhMjApOiByZWY9MgpoY2lkWzU3NTNdOiBB
dWRpbyBBUEk6IHNlbmRpbmcgQlRfU1RSRUFNU1RBUlRfUlNQCmhjaWRbNTc1M106IEF1ZGlvIEFQ
STogc2VuZGluZyBCVF9TVFJFQU1GRF9JTkQKaGNpZFs1NzUzXTogc2V0dXBfdW5yZWYoMHg4MDk3
YTIwKTogcmVmPTEKaGNpZFs1NzUzXTogc2V0dXBfdW5yZWYoMHg4MDk3YTIwKTogcmVmPTAKaGNp
ZFs1NzUzXTogc2V0dXBfZnJlZSgweDgwOTdhMjApCmhjaWRbNTc1M106IGF2ZHRwX3VucmVmKDB4
ODA4Y2E2MCk6IHJlZj0zCmhjaWRbNTc1M106IEF1ZGlvIEFQSTogcmVjZWl2ZWQgQlRfU1RSRUFN
U1RBUlRfUkVRCmhjaWRbNTc1M106IGF2ZHRwX3JlZigweDgwOGNhNjApOiByZWY9NApoY2lkWzU3
NTNdOiBzZXR1cF9yZWYoMHg4MDk3YTIwKTogcmVmPTEKaGNpZFs1NzUzXTogc2V0dXBfcmVmKDB4
ODA5N2EyMCk6IHJlZj0yCmhjaWRbNTc1M106IEF1ZGlvIEFQSTogc2VuZGluZyBCVF9TVFJFQU1T
VEFSVF9SU1AKaGNpZFs1NzUzXTogQXVkaW8gQVBJOiBzZW5kaW5nIEJUX1NUUkVBTUZEX0lORApo
Y2lkWzU3NTNdOiBzZXR1cF91bnJlZigweDgwOTdhMjApOiByZWY9MQpoY2lkWzU3NTNdOiBzZXR1
cF91bnJlZigweDgwOTdhMjApOiByZWY9MApoY2lkWzU3NTNdOiBzZXR1cF9mcmVlKDB4ODA5N2Ey
MCkKaGNpZFs1NzUzXTogYXZkdHBfdW5yZWYoMHg4MDhjYTYwKTogcmVmPTMKaGNpZFs1NzUzXTog
cGluX2NvZGVfcmVxdWVzdCAoc2JhPTAwOjExOjY3OjUyOjI5OjIzLCBkYmE9MDA6MDc6QTQ6QjU6
RDg6OUUpCmhjaWRbNTc1M106IENhbGxpbmcgUGFzc2tleUFnZW50LlJlcXVlc3Q6IG5hbWU9OjEu
MTcsIHBhdGg9L29yZy9ibHVlei9wYXNza2V5CmhjaWRbNTc1M106IE5ldyBSZXF1ZXN0IEFQSSBm
YWlsZWQsIHRyeWluZyBvbGQgb25lCmhjaWRbNTc1M106IC9vcmcvYmx1ZXovaGNpMDogb3JnLmJs
dWV6LkFkYXB0ZXIuR2V0TmFtZSgpCmhjaWRbNTc1M106IC9vcmcvYmx1ZXovaGNpMDogb3JnLmJs
dWV6LkFkYXB0ZXIuR2V0UmVtb3RlTmFtZSgpCmhjaWRbNTc1M106IEFWQ1RQOiBpbmNvbWluZyBj
b25uZWN0IGZyb20gMDA6MDc6QTQ6QjU6RDg6OUUKaGNpZFs1NzUzXTogQ2FuJ3Qgb3BlbiBpbnB1
dCBkZXZpY2U6IE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkgKDIpCmhjaWRbNTc1M106IEFWUkNQ
OiBmYWlsZWQgdG8gaW5pdCB1aW5wdXQgZm9yIE1vdG9yb2xhIEhUODIwCgo=

------_=_NextPart_001_01C8B655.C36EF452
Content-Type: application/octet-stream; name="bluez-startup.log"
Content-Transfer-Encoding: base64
Content-Description: bluez-startup.log
Content-Disposition: attachment; filename="bluez-startup.log"

cm9vdEBhemhhbzJ1YnRnMjp+IyBoY2lkIC1kIC1uCmhjaWRbNTc1M106IEJsdWV0b290aCBIQ0kg
ZGFlbW9uCmhjaWRbNTc1M106IEVuYWJsaW5nIGRlYnVnIGluZm9ybWF0aW9uCmhjaWRbNTc1M106
IEhDSSBkZXYgMCByZWdpc3RlcmVkCmhjaWRbNTc1M106IEhDSSBkZXYgMCBhbHJlYWR5IHVwCmhj
aWRbNTc1M106IERldmljZSBoY2kwIGhhcyBiZWVuIGFkZGVkCmhjaWRbNTc1M106IFN0YXJ0aW5n
IHNlY3VyaXR5IG1hbmFnZXIgMApoY2lkWzU3NTNdOiBEZXZpY2UgaGNpMCBoYXMgYmVlbiBhY3Rp
dmF0ZWQKaGNpZFs1NzUzXTogU3RhcnRpbmcgU0RQIHNlcnZlcgpoY2lkWzU3NTNdOiBBZGRpbmcg
cmVjIDogMHg4MDkyNzI4CmhjaWRbNTc1M106IHdpdGggaGFuZGxlIDogMHgxCmhjaWRbNTc1M106
IEFkZGluZyByZWMgOiAweDgwOTJhYjAKaGNpZFs1NzUzXTogd2l0aCBoYW5kbGUgOiAweDAKaGNp
ZFs1NzUzXTogU2VydmljZSBjbGFzc2VzIDB4MDAKaGNpZFs1NzUzXTogTG9hZGluZyBwbHVnaW5z
IC91c3IvbGliL2JsdWV0b290aC9wbHVnaW5zCmhjaWRbNTc1M106IC91c3IvbGliL2JsdWV0b290
aC9wbHVnaW5zL2xpYnN0b3JhZ2Uuc28KaGNpZFs1NzUzXTogL3Vzci9saWIvYmx1ZXRvb3RoL3Bs
dWdpbnMvbGlibmV0d29yay5zbwpoY2lkWzU3NTNdOiAvZXRjL2JsdWV0b290aC9uZXR3b3JrLmNv
bmY6IC9ldGMvYmx1ZXRvb3RoL25ldHdvcmsuY29uZjogTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9y
eQpoY2lkWzU3NTNdOiAvZXRjL2JsdWV0b290aC9uZXR3b3JrLmNvbmY6IC9ldGMvYmx1ZXRvb3Ro
L25ldHdvcmsuY29uZjogTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeQpoY2lkWzU3NTNdOiAvZXRj
L2JsdWV0b290aC9uZXR3b3JrLmNvbmY6IC9ldGMvYmx1ZXRvb3RoL25ldHdvcmsuY29uZjogTm8g
c3VjaCBmaWxlIG9yIGRpcmVjdG9yeQpoY2lkWzU3NTNdOiAvZXRjL2JsdWV0b290aC9uZXR3b3Jr
LmNvbmY6IC9ldGMvYmx1ZXRvb3RoL25ldHdvcmsuY29uZjogTm8gc3VjaCBmaWxlIG9yIGRpcmVj
dG9yeQpoY2lkWzU3NTNdOiAvZXRjL2JsdWV0b290aC9uZXR3b3JrLmNvbmY6IC9ldGMvYmx1ZXRv
b3RoL25ldHdvcmsuY29uZjogTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeQpoY2lkWzU3NTNdOiAv
ZXRjL2JsdWV0b290aC9uZXR3b3JrLmNvbmY6IC9ldGMvYmx1ZXRvb3RoL25ldHdvcmsuY29uZjog
Tm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeQpoY2lkWzU3NTNdOiAvZXRjL2JsdWV0b290aC9uZXR3
b3JrLmNvbmY6IC9ldGMvYmx1ZXRvb3RoL25ldHdvcmsuY29uZjogTm8gc3VjaCBmaWxlIG9yIGRp
cmVjdG9yeQpoY2lkWzU3NTNdOiAvZXRjL2JsdWV0b290aC9uZXR3b3JrLmNvbmY6IC9ldGMvYmx1
ZXRvb3RoL25ldHdvcmsuY29uZjogTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeQpoY2lkWzU3NTNd
OiBDb25maWcgb3B0aW9uczogSW50ZXJmYWNlUHJlZml4PWJuZXAlZCwgUEFOVV9TY3JpcHQ9KG51
bGwpLCBHTl9TY3JpcHQ9KG51bGwpLCBOQVBfU2NyaXB0PShudWxsKSwgR05fSW50ZXJmYWNlPXBh
bjAsIE5BUF9JbnRlcmZhY2U9cGFuMSwgU2VjdXJpdHk9dHJ1ZQpoY2lkWzU3NTNdOiBDYW4ndCBj
cmVhdGUgR04gYnJpZGdlCmhjaWRbNTc1M106IFJlZ2lzdGVyZWQgbWFuYWdlciBwYXRoOi9vcmcv
Ymx1ZXovbmV0d29yawpoY2lkWzU3NTNdOiBSZWdpc3RlcmVkIHNlcnZlciBwYXRoOi9vcmcvYmx1
ZXovbmV0d29yay9uYXAKaGNpZFs1NzUzXTogUmVnaXN0ZXJlZCBzZXJ2ZXIgcGF0aDovb3JnL2Js
dWV6L25ldHdvcmsvZ24KaGNpZFs1NzUzXTogUmVnaXN0ZXJlZCBzZXJ2ZXIgcGF0aDovb3JnL2Js
dWV6L25ldHdvcmsvcGFudQpoY2lkWzU3NTNdOiBSZWdpc3RlcmluZyBzZXJ2aWNlCmhjaWRbNTc1
M106IENhbid0IGxvYWQgcGx1Z2luOiAvdXNyL2xpYi9ibHVldG9vdGgvcGx1Z2lucy9saWJzZXJp
YWwuc286IHVuZGVmaW5lZCBzeW1ib2w6IGdfYXNjaWlfaXN4ZGlnaXQKaGNpZFs1NzUzXTogL3Vz
ci9saWIvYmx1ZXRvb3RoL3BsdWdpbnMvbGliaW5wdXQuc28KaGNpZFs1NzUzXTogUmVnaXN0ZXJl
ZCBpbnB1dCBtYW5hZ2VyIHBhdGg6L29yZy9ibHVlei9pbnB1dApoY2lkWzU3NTNdOiBSZWdpc3Rl
cmluZyBzZXJ2aWNlCmhjaWRbNTc1M106IC91c3IvbGliL2JsdWV0b290aC9wbHVnaW5zL2xpYmF1
ZGlvLnNvCmhjaWRbNTc1M106IFVuaXggc29ja2V0IGNyZWF0ZWQ6IDE4CmhjaWRbNTc1M106IGF1
ZGlvLmNvbmY6IC9ldGMvYmx1ZXRvb3RoL2F1ZGlvLmNvbmY6IE5vIHN1Y2ggZmlsZSBvciBkaXJl
Y3RvcnkKaGNpZFs1NzUzXTogYXVkaW8uY29uZjogL2V0Yy9ibHVldG9vdGgvYXVkaW8uY29uZjog
Tm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeQpoY2lkWzU3NTNdOiBhdWRpby5jb25mOiAvZXRjL2Js
dWV0b290aC9hdWRpby5jb25mOiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5CmhjaWRbNTc1M106
IGF1ZGlvLmNvbmY6IC9ldGMvYmx1ZXRvb3RoL2F1ZGlvLmNvbmY6IE5vIHN1Y2ggZmlsZSBvciBk
aXJlY3RvcnkKaGNpZFs1NzUzXTogQ291bGRuJ3QgZmluZCByZWNvcmQgZm9yIDogMHgxMDAwMApo
Y2lkWzU3NTNdOiBBZGRpbmcgcmVjb3JkIHdpdGggaGFuZGxlIDB4MTAwMDAKaGNpZFs1NzUzXTog
QWRkaW5nIHJlYyA6IDB4ODA5NTQ4OApoY2lkWzU3NTNdOiB3aXRoIGhhbmRsZSA6IDB4MTAwMDAK
aGNpZFs1NzUzXTogU2VydmljZSBjbGFzc2VzIDB4MDAKaGNpZFs1NzUzXTogYXVkaW8uY29uZjog
L2V0Yy9ibHVldG9vdGgvYXVkaW8uY29uZjogTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeQpoY2lk
WzU3NTNdOiBhdWRpby5jb25mOiAvZXRjL2JsdWV0b290aC9hdWRpby5jb25mOiBObyBzdWNoIGZp
bGUgb3IgZGlyZWN0b3J5CmhjaWRbNTc1M106IGF1ZGlvLmNvbmY6IC9ldGMvYmx1ZXRvb3RoL2F1
ZGlvLmNvbmY6IE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkKaGNpZFs1NzUzXTogYXVkaW8uY29u
ZjogL2V0Yy9ibHVldG9vdGgvYXVkaW8uY29uZjogTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeQpo
Y2lkWzU3NTNdOiBhdWRpby5jb25mOiAvZXRjL2JsdWV0b290aC9hdWRpby5jb25mOiBObyBzdWNo
IGZpbGUgb3IgZGlyZWN0b3J5CmhjaWRbNTc1M106IGF1ZGlvLmNvbmY6IC9ldGMvYmx1ZXRvb3Ro
L2F1ZGlvLmNvbmY6IE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkKaGNpZFs1NzUzXTogYXVkaW8u
Y29uZjogL2V0Yy9ibHVldG9vdGgvYXVkaW8uY29uZjogTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9y
eQpoY2lkWzU3NTNdOiBhdWRpby5jb25mOiAvZXRjL2JsdWV0b290aC9hdWRpby5jb25mOiBObyBz
dWNoIGZpbGUgb3IgZGlyZWN0b3J5CmhjaWRbNTc1M106IGF1ZGlvLmNvbmY6IC9ldGMvYmx1ZXRv
b3RoL2F1ZGlvLmNvbmY6IE5vIHN1Y2ggZmlsZSBvciBkaXJlY3RvcnkKaGNpZFs1NzUzXTogYXVk
aW8uY29uZjogL2V0Yy9ibHVldG9vdGgvYXVkaW8uY29uZjogTm8gc3VjaCBmaWxlIG9yIGRpcmVj
dG9yeQpoY2lkWzU3NTNdOiBDb3VsZG4ndCBmaW5kIHJlY29yZCBmb3IgOiAweDEwMDAxCmhjaWRb
NTc1M106IEFkZGluZyByZWNvcmQgd2l0aCBoYW5kbGUgMHgxMDAwMQpoY2lkWzU3NTNdOiBBZGRp
bmcgcmVjIDogMHg4MDk1Y2M4CmhjaWRbNTc1M106IHdpdGggaGFuZGxlIDogMHgxMDAwMQpoY2lk
WzU3NTNdOiBTZXJ2aWNlIGNsYXNzZXMgMHgwMApoY2lkWzU3NTNdOiBhdWRpby5jb25mOiAvZXRj
L2JsdWV0b290aC9hdWRpby5jb25mOiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5CmhjaWRbNTc1
M106IGF1ZGlvLmNvbmY6IC9ldGMvYmx1ZXRvb3RoL2F1ZGlvLmNvbmY6IE5vIHN1Y2ggZmlsZSBv
ciBkaXJlY3RvcnkKaGNpZFs1NzUzXTogYXVkaW8uY29uZjogL2V0Yy9ibHVldG9vdGgvYXVkaW8u
Y29uZjogTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeQpoY2lkWzU3NTNdOiBhdWRpby5jb25mOiAv
ZXRjL2JsdWV0b290aC9hdWRpby5jb25mOiBObyBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5CmhjaWRb
NTc1M106IGF1ZGlvLmNvbmY6IC9ldGMvYmx1ZXRvb3RoL2F1ZGlvLmNvbmY6IE5vIHN1Y2ggZmls
ZSBvciBkaXJlY3RvcnkKaGNpZFs1NzUzXTogYXVkaW8uY29uZjogL2V0Yy9ibHVldG9vdGgvYXVk
aW8uY29uZjogTm8gc3VjaCBmaWxlIG9yIGRpcmVjdG9yeQpoY2lkWzU3NTNdOiBTRVAgMHg4MDk2
MWQ4IHJlZ2lzdGVyZWQ6IHR5cGU6MCBjb2RlYzowIHNlaWQ6MQpoY2lkWzU3NTNdOiBDb3VsZG4n
dCBmaW5kIHJlY29yZCBmb3IgOiAweDEwMDAyCmhjaWRbNTc1M106IEFkZGluZyByZWNvcmQgd2l0
aCBoYW5kbGUgMHgxMDAwMgpoY2lkWzU3NTNdOiBBZGRpbmcgcmVjIDogMHg4MDk2MjA4CmhjaWRb
NTc1M106IHdpdGggaGFuZGxlIDogMHgxMDAwMgpoY2lkWzU3NTNdOiBTZXJ2aWNlIGNsYXNzZXMg
MHgwOApoY2lkWzU3NTNdOiBhdWRpby5jb25mOiAvZXRjL2JsdWV0b290aC9hdWRpby5jb25mOiBO
byBzdWNoIGZpbGUgb3IgZGlyZWN0b3J5CmhjaWRbNTc1M106IENvdWxkbid0IGZpbmQgcmVjb3Jk
IGZvciA6IDB4MTAwMDMKaGNpZFs1NzUzXTogQWRkaW5nIHJlY29yZCB3aXRoIGhhbmRsZSAweDEw
MDAzCmhjaWRbNTc1M106IEFkZGluZyByZWMgOiAweDgwOTVmYTgKaGNpZFs1NzUzXTogd2l0aCBo
YW5kbGUgOiAweDEwMDAzCmhjaWRbNTc1M106IFNlcnZpY2UgY2xhc3NlcyAweDA4CmhjaWRbNTc1
M106IENvdWxkbid0IGZpbmQgcmVjb3JkIGZvciA6IDB4MTAwMDQKaGNpZFs1NzUzXTogQWRkaW5n
IHJlY29yZCB3aXRoIGhhbmRsZSAweDEwMDA0CmhjaWRbNTc1M106IEFkZGluZyByZWMgOiAweDgw
OTY0YTAKaGNpZFs1NzUzXTogd2l0aCBoYW5kbGUgOiAweDEwMDA0CmhjaWRbNTc1M106IFNlcnZp
Y2UgY2xhc3NlcyAweDA4CmhjaWRbNTc1M106IFJlZ2lzdGVyZWQgbWFuYWdlciBwYXRoOi9vcmcv
Ymx1ZXovYXVkaW8KaGNpZFs1NzUzXTogTG9hZGluZyBkZXZpY2UgMDA6MDc6QTQ6QjU6RDg6OUUg
KGhlYWRzZXQgc2luayApCmhjaWRbNTc1M106IFNlbGVjdGluZyBkZWZhdWx0IGRldmljZQpoY2lk
WzU3NTNdOiBSZWdpc3RlcmluZyBzZXJ2aWNlCmhjaWRbNTc1M106IFJlZ2lzdGVyaW5nIHNlcnZp
Y2Ugb2JqZWN0OiBpZGVudD1uZXR3b3JrLCBuYW1lPU5ldHdvcmsgc2VydmljZSAoL29yZy9ibHVl
ei9zZXJ2aWNlX25ldHdvcmspCmhjaWRbNTc1M106IFJlZ2lzdGVyaW5nIHNlcnZpY2Ugb2JqZWN0
OiBpZGVudD1hdWRpbywgbmFtZT1BdWRpbyBzZXJ2aWNlICgvb3JnL2JsdWV6L3NlcnZpY2VfYXVk
aW8pCmhjaWRbNTc1M106IC91c3IvbGliL2JsdWV0b290aC9ibHVldG9vdGhkLXNlcnZpY2UtYXVk
aW8gZXhlY3V0ZWQgd2l0aCBQSUQgNTc1NgpoY2lkWzU3NTNdOiBSZWdpc3RlcmluZyBzZXJ2aWNl
IG9iamVjdDogaWRlbnQ9aW5wdXQsIG5hbWU9SW5wdXQgc2VydmljZSAoL29yZy9ibHVlei9zZXJ2
aWNlX2lucHV0KQphdWRpb1s1NzU2XTogQmx1ZXRvb3RoIEF1ZGlvIGRhZW1vbgphdWRpb1s1NzU2
XTogUGFyc2luZyAvZXRjL2JsdWV0b290aC9hdWRpby5jb25mIGZhaWxlZDogTm8gc3VjaCBmaWxl
IG9yIGRpcmVjdG9yeQpoY2lkWzU3NTNdOiAvdXNyL2xpYi9ibHVldG9vdGgvYmx1ZXRvb3RoZC1z
ZXJ2aWNlLWlucHV0IGV4ZWN1dGVkIHdpdGggUElEIDU3NTcKaGNpZFs1NzUzXTogUmVnaXN0ZXJp
bmcgc2VydmljZSBvYmplY3Q6IGlkZW50PXNlcmlhbCwgbmFtZT1TZXJpYWwgc2VydmljZSAoL29y
Zy9ibHVlei9zZXJ2aWNlX3NlcmlhbCkKaW5wdXRbNTc1N106IEJsdWV0b290aCBJbnB1dCBkYWVt
b24KYXVkaW9bNTc1Nl06IENhbid0IGJpbmQgdW5peCBzb2NrZXQ6IEFkZHJlc3MgYWxyZWFkeSBp
biB1c2UgKDk4KQphdWRpb1s1NzU2XTogVW5hYmxlIHRvIHNldHVwIHVuaXggc29ja2V0CmlucHV0
WzU3NTddOiBSZWdpc3RlcmVkIGlucHV0IG1hbmFnZXIgcGF0aDovb3JnL2JsdWV6L2lucHV0Cmlu
cHV0WzU3NTddOiBGYWlsZWQgdG8gbGlzdGVuIG9uIGNvbnRyb2wgY2hhbm5lbApoY2lkWzU3NTNd
OiBjaGlsZCA1NzU0IGV4aXRlZApoY2lkWzU3NTNdOiBjaGlsZCA1NzU1IGV4aXRlZApoY2lkWzU3
NTNdOiBBdWRpbyBzZXJ2aWNlIChhdWRpbykgZXhpdGVkIHdpdGggc3RhdHVzIDEKaGNpZFs1NzUz
XTogL29yZy9ibHVlejogb3JnLmJsdWV6LlNlY3VyaXR5LlJlZ2lzdGVyRGVmYXVsdFBhc3NrZXlB
Z2VudCgpCmhjaWRbNTc1M106IG5hbWVfbGlzdGVuZXJfYWRkKDoxLjE3KQpoY2lkWzU3NTNdOiBE
ZWZhdWx0IHBhc3NrZXkgYWdlbnQgKDoxLjE3LCAvb3JnL2JsdWV6L3Bhc3NrZXkpIHJlZ2lzdGVy
ZWQKaGNpZFs1NzUzXTogL29yZy9ibHVlejogb3JnLmJsdWV6LkRhdGFiYXNlLlJlZ2lzdGVyU2Vy
dmljZSgpCmhjaWRbNTc1M106IC9vcmcvYmx1ZXo6IG9yZy5ibHVlei5EYXRhYmFzZS5SZWdpc3Rl
clNlcnZpY2UoKQpoY2lkWzU3NTNdOiAvb3JnL2JsdWV6OiBvcmcuYmx1ZXouRGF0YWJhc2UuUmVn
aXN0ZXJTZXJ2aWNlKCkKaGNpZFs1NzUzXTogU2VuZGluZyBHZXRDb25uZWN0aW9uVW5peFByb2Nl
c3NJRCBmYWlsZWQ6IENvdWxkIG5vdCBnZXQgUElEIG9mIG5hbWUgJzoxLjI2Jzogbm8gc3VjaCBu
YW1lCmhjaWRbNTc1M106IENvdWxkIG5vdCBnZXQgUElEIG9mIDoxLjI2CmhjaWRbNTc1M106IENo
aWxkIFBJRCA1NzU3IGdvdCB0aGUgdW5pcXVlIGJ1cyBuYW1lIDoxLjI3CmhjaWRbNTc1M106IG5h
bWVfbGlzdGVuZXJfYWRkKDoxLjI3KQpoY2lkWzU3NTNdOiBHb3QgTmFtZU93bmVyQ2hhbmdlZCBz
aWduYWwgZm9yIDoxLjI2IHdoaWNoIGhhcyBubyBsaXN0ZW5lcnMKaGNpZFs1NzUzXTogL29yZy9i
bHVlejogb3JnLmJsdWV6LlNlY3VyaXR5LlJlZ2lzdGVyRGVmYXVsdEF1dGhvcml6YXRpb25BZ2Vu
dCgpCmhjaWRbNTc1M106IERlZmF1bHQgYXV0aG9yaXphdGlvbiBhZ2VudCAoOjEuMTcsIC9vcmcv
Ymx1ZXovYXV0aCkgcmVnaXN0ZXJlZApoY2lkWzU3NTNdOiBTZXJ2aWNlIHJlZ2lzdGVyIHJlcGx5
CmhjaWRbNTc1M106IFNlcnZpY2UgcmVnaXN0ZXIgcmVwbHkKaGNpZFs1NzUzXTogU2VydmljZSBy
ZWdpc3RlciByZXBseQpoY2lkWzU3NTNdOiAvb3JnL2JsdWV6L2hjaTA6IG9yZy5ibHVlei5BZGFw
dGVyLkdldE5hbWUoKQpmCg==

------_=_NextPart_001_01C8B655.C36EF452
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

-------------------------------------------------------------------------
This SF.net email is sponsored by: Microsoft 
Defy all challenges. Microsoft(R) Visual Studio 2008. 
http://clk.atdmt.com/MRT/go/vse0120000070mrt/direct/01/
------_=_NextPart_001_01C8B655.C36EF452
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Bluez-devel mailing list
Bluez-devel@lists.sourceforge.net
https://lists.sourceforge.net/lists/listinfo/bluez-devel

------_=_NextPart_001_01C8B655.C36EF452--
