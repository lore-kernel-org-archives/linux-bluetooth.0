Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <65A6897373DD1D478DA815A9759D0E0A66575A48@BGSMSX108.gar.corp.intel.com>
References: <1507802154-3960-1-git-send-email-jaganathx.kanakkassery@intel.com>
 <65A6897373DD1D478DA815A9759D0E0A66575A48@BGSMSX108.gar.corp.intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Mon, 23 Oct 2017 14:25:39 +0300
Message-ID: <CABBYNZ+KBCL=YLy_P9j1tnn1E08os5=NUpCFkG+zUKOJjLR-3g@mail.gmail.com>
Subject: Re: [PATCH 1/3] Bluetooth: Introduce helpers for LE set scan start
 and complete
To: "Kanakkassery, JaganathX" <jaganathx.kanakkassery@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jaganath,

On Mon, Oct 23, 2017 at 9:03 AM, Kanakkassery, JaganathX
<jaganathx.kanakkassery@intel.com> wrote:
> Hi.
>
>>Introduce a helper hci_req_start_scan() which starts an LE scan and call it from passive_Scan() and active_scan().
>>There is not functionality change in this patch.
>>
>>This is basically done to enable extended scanning if the controller supports which will be done in the subsequent patch
>>
>>Signed-off-by: Jaganath Kanakkassery <jaganathx.kanakkassery@intel.com>
>
> Any update on this patch set Plz?
>

Acked-by: Luiz Augusto von Dentz <luiz.von.dentz@intel.com>


> Thanks,
> Jaganath
> --
> To unsubscribe from this list: send the line "unsubscribe linux-bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html



-- 
Luiz Augusto von Dentz
