Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1560638.biMD7yTzvv@athlon>
References: <1560638.biMD7yTzvv@athlon>
Date: Fri, 21 Jun 2013 18:38:34 -0400
Message-ID: <CAJdJm_P90hv0PHwpk+VNSx=OivsLiA7bBSvS4E=4=6mT_BR81A@mail.gmail.com>
Subject: Re: regression in sdp lib
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Szymon Janc <szymon.janc@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Szymon,

On Fri, Jun 21, 2013 at 4:09 PM, Szymon Janc <szymon.janc@gmail.com> wrote:
> Hi,
>
> commit 'lib: Add range check for SDP_SVC_ATTR_RSP/SDP_SVC_SEARCH_ATTR_RSP'
> 1796f00e846561af broke sdp with Nokia BH217 headset.

Note that the commit only exposed the issue that the handling of these
PDUs does not expect continuation PDUs. The reason the previous code
worked was purely by luck, because the sdp_process() function
allocates a large buffer and memset()s it to zero, so "pcstate" most
likely will be zero (indicating the last continuation packet).

>
>
> As discussed on IRC, sending bluetoothd and monitor logs.
>
> It looks like if response is fragmented size should be verified after all
> fragments are received, not for each fragment in separate..
>
> I'm not sure how this should be fixed correctly. Suggestions are welcome.

Can you send the raw dump as well? hcidump shows SDP information that
is not necessarily present on the PDU (but is collected/calculated
from previous PDUs).

One idea for a fix is to handle like the SDP_SVC_SEARCH_RSP, i.e.
something like:

if (t->rsp_concat_buf.data_size == 0)
    rsp_count = bt_get_be16(pdata);
else if (t->rsp_concat_buf.data_size >= sizeof(rsp_count))
    rsp_count = bt_get_be16(t->rsp_concat_buf.data);


Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
