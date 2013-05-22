Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1369255996-28230-1-git-send-email-luiz.dentz@gmail.com>
References: <1369255996-28230-1-git-send-email-luiz.dentz@gmail.com>
Date: Wed, 22 May 2013 18:31:31 -0400
Message-ID: <CAJdJm_Mnk8+b6x4=vqdGT-G61u=vOFa_S4C=htn_LQ5iiLvGaw@mail.gmail.com>
Subject: Re: [PATCH BlueZ] lib: Fix sdp_seq_alloc_with_length accessing
 invalid index/memory
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Luiz,

On Wed, May 22, 2013 at 4:53 PM, Luiz Augusto von Dentz
<luiz.dentz@gmail.com> wrote:
> From: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>
>
> The sequence itself is not an index of dtds, values, lenghts, thats why
> SDP_SEQ8 is used directly as dtd, so accessing lenght[i] is always off
> by one.
>
> Furthermore the lenght is not really used by sdp_data_alloc_with_length
> when the dtd is SDP_SEQ8.

small typo: lenght -> length (3 occurrences).

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
