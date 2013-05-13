Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <20130513130939.GA10517@samus.indt.org>
References: <1368341952-5666-1-git-send-email-luiz.dentz@gmail.com>
	<20130513130939.GA10517@samus.indt.org>
Date: Mon, 13 May 2013 18:02:14 +0300
Message-ID: <CABBYNZ+00O1cZbzwW0_J8U4tmEu=vKgj5Z40JVo=-QiBkJBwGA@mail.gmail.com>
Subject: Re: [RFC BlueZ] AVRCP: Fix crash when no A2DP role is detected
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Vinicius,

On Mon, May 13, 2013 at 4:09 PM, Vinicius Costa Gomes
<vinicius.gomes@openbossa.org> wrote:
> Hi Luiz,
>
> On 09:59 Sun 12 May, Luiz Augusto von Dentz wrote:
>> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>>
>> Invalid read of size 4
>>    at 0x468370: btd_service_connecting_complete (service.c:315)
>>    by 0x41B70F: session_ct_init_control (avrcp.c:2790)
>>    by 0x41B1E0: state_changed (avrcp.c:2933)
>>    by 0x418054: avctp_set_state (avctp.c:548)
>>    by 0x41A2E4: avctp_connect_cb (avctp.c:1201)
>>    by 0x44F989: accept_cb (btio.c:201)
>>    by 0x4E77044: g_main_context_dispatch (in /usr/lib64/libglib-2.0.so.0.3400.2)
>>    by 0x4E77377: g_main_context_iterate.isra.24 (in /usr/lib64/libglib-2.0.so.0.3400.2)
>>    by 0x4E77771: g_main_loop_run (in /usr/lib64/libglib-2.0.so.0.3400.2)
>>    by 0x40A8EE: main (main.c:583)
>>  Address 0x20 is not stack'd, malloc'd or (recently) free'd
>>
>>  If no A2DP is found assume the controller is the initiator.
>
>
> This patch indeed fixes the crash. Ack.

We were discussing about this problem offline, it doesn't seems very
clear how we end up with control being NULL like this and it is
desirable to have such information in the description because perhaps
we are fixing this in the wrong place after all. Can you explain how
exactly you managed to reproduced the problem?


--
Luiz Augusto von Dentz
