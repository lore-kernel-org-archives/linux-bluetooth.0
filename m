Return-Path: <cyrus@holtmann.org>
From: <h.patil@accenture.com>
To: <linux-bluetooth@vger.kernel.org>, <luiz.dentz-von@nokia.com>
Date: Wed, 1 Jun 2011 16:42:48 +0530
Subject: RE: A2DP Connection problem
Message-ID: <AA5DFB06574FF54BA4A76C3F1040DCBB11C1E58C45@INDXM3131.dir.svc.accenture.com>
References: <1305795079-5251-1-git-send-email-dmitriy.paliy@nokia.com>
	 <1305795079-5251-3-git-send-email-dmitriy.paliy@nokia.com>
	 <AA5DFB06574FF54BA4A76C3F1040DCBB11C18DE91D@INDXM3131.dir.svc.accenture.com>
 <1305797659.2388.11.camel@dentz-desktop>
In-Reply-To: <1305797659.2388.11.camel@dentz-desktop>
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,
          I am using Infineon PBA31308 BT chip with arm board.
          Do you any idea?
          Still I am facing same problem.

Thanks
Patil


-----Original Message-----
From: linux-bluetooth-owner@vger.kernel.org [mailto:linux-bluetooth-owner@vger.kernel.org] On Behalf Of Luiz Augusto von Dentz
Sent: Thursday, May 19, 2011 3:04 PM
To: Patil, H.
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: A2DP Connection problem

Hi,

On Thu, 2011-05-19 at 14:44 +0530, ext h.patil@accenture.com wrote:
> Hi All,
>
> I am working on A2DP-bluez, using latest version of bluez which is
> 4.93, I am able to establish A2DP connection using dbus API's, after
> 10 seconds my connection is getting losted .please find the below log
> and please do help me.
>
>
>
> bluetoothd[1509]: audio/a2dp.c:a2dp_config() Configuration match:
> resuming
>
> bluetoothd[1509]: audio/unix.c:unix_ipc_sendmsg() Audio API:
> BT_RESPONSE -> BT_SET_CONFIGURATION
>
> bluetoothd[1509]: audio/a2dp.c:setup_unref() 0x54b7d3e0: ref=0
>
> bluetoothd[1509]: audio/a2dp.c:setup_free() 0x54b7d3e0
>
> bluetoothd[1509]: audio/avdtp.c:avdtp_unref() 0x54b93370: ref=3
>
> bluetoothd[1509]: audio/unix.c:client_cb() Audio API: BT_REQUEST <-
> BT_START_STREAM
>
> bluetoothd[1509]: audio/avdtp.c:avdtp_ref() 0x54b93370: ref=4
>
> bluetoothd[1509]: audio/a2dp.c:setup_ref() 0x54b7d3e0: ref=1
>
> bluetoothd[1509]: audio/avdtp.c:session_cb()
>
> bluetoothd[1509]: audio/avdtp.c:avdtp_parse_cmd() Received
> DISCOVER_CMD
>
> bluetoothd[1509]: audio/avdtp.c:session_cb()
>
> bluetoothd[1509]: START request rejected: Bad Acceptor SEID (18)

Strange, how come you manage to get a bad seid? I tough you were using
PulseAudio since I saw your messages on its mailing list, but afaik it
should not cause such behavior. Well it could also be that the remote
device is not working properly too, which device is that?

>
> bluetoothd[1509]: audio/a2dp.c:start_cfm() Sink 0x54b48aa0: Start_Cfm
>
> bluetoothd[1509]: resume failed
>
> bluetoothd[1509]: audio/unix.c:unix_ipc_error() sending error
> Input/output error(5)
>
> bluetoothd[1509]: audio/unix.c:unix_ipc_sendmsg() Audio API: BT_ERROR
> -> BT_START_STREAM
>
> bluetoothd[1509]: audio/a2dp.c:a2dp_sep_unlock() SEP 0x54b48aa0
> unlocked
>
> bluetoothd[1509]: audio/avdtp.c:avdtp_unref() 0x54b93370: ref=3
>
> bluetoothd[1509]: audio/a2dp.c:setup_unref() 0x54b7d3e0: ref=0
>
> bluetoothd[1509]: audio/a2dp.c:setup_free() 0x54b7d3e0
>
> bluetoothd[1509]: audio/avdtp.c:avdtp_unref() 0x54b93370: ref=2
>
> bluetoothd[1509]: audio/unix.c:client_cb() Unix client disconnected
> (fd=26)
>
> bluetoothd[1509]: audio/unix.c:client_free() client_free(0x54b455d0)
>
> bluetoothd[1509]: audio/avdtp.c:session_cb()
>
> bluetoothd[1509]: audio/avdtp.c:avdtp_parse_cmd() Received START_CMD
>
> bluetoothd[1509]: audio/a2dp.c:start_ind() Sink 0x54b48aa0: Start_Ind
>
> bluetoothd[1509]: audio/avdtp.c:avdtp_ref() 0x54b93370: ref=3
>
> bluetoothd[1509]: audio/avdtp.c:avdtp_sep_set_state() stream state
> changed: OPEN -> STREAMING
>
> bluetoothd[1509]: audio/avdtp.c:avdtp_unref() 0x54b93370: ref=2
>
> bluetoothd[1509]: Suspend: Connection timed out (110)
>
> bluetoothd[1509]: audio/a2dp.c:suspend_cfm() Sink 0x54b48aa0:
> Suspend_Cfm
>
> bluetoothd[1509]: Abort: Connection timed out (110)
>
> bluetoothd[1509]: audio/avdtp.c:connection_lost() Disconnected from
> 00:25:CF:03:FE:AE
>
> bluetoothd[1509]: audio/a2dp.c:abort_cfm() Sink 0x54b48aa0: Abort_Cfm
>
> bluetoothd[1509]: audio/avdtp.c:avdtp_sep_set_state() stream state
> changed: STREAMING -> IDLE
>
> bluetoothd[1509]: audio/avdtp.c:avdtp_unref() 0x54b93370: ref=1
>
> bluetoothd[1509]: audio/avdtp.c:avdtp_unref() 0x54b93370: ref=0
>
> bluetoothd[1509]: audio/avdtp.c:avdtp_unref() 0x54b93370: freeing
> session and removing from list

If there is no client connected like you can see above the stream will
auto suspend in 5 seconds. Btw this timeout normally indicates that the
remote device either crashed or is in bad state.


--
To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html


This message is for the designated recipient only and may contain privileged, proprietary, or otherwise private information.  If you have received it in error, please notify the sender immediately and delete the original.  Any other use of the email by you is prohibited.
