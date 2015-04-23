Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1429617947-5784-1-git-send-email-bharat.panda@samsung.com>
References: <1429617947-5784-1-git-send-email-bharat.panda@samsung.com>
Date: Thu, 23 Apr 2015 18:37:54 +0300
Message-ID: <CABBYNZJF=FXrFDaqtEXVX_Doe8A2bzHeGV9OqwAJFAKxb24_dQ@mail.gmail.com>
Subject: Re: [PATCH 0/3] Add support for decoding AVRCP browsing packets
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bharat Panda <bharat.panda@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bharat,

On Tue, Apr 21, 2015 at 3:05 PM, Bharat Panda <bharat.panda@samsung.com> wrote:
> Decodes below AVRCP browsing packets,
>
> 1) Get Item Attibutes
> 2) Search Item
> 3) General Reject
>
> Bharat Panda (3):
>   monitor: Add Support for AVRCP GetItemAttributes
>   monitor: Add support for AVRCP Search
>   monitor: Add support for AVRCP GeneralReject
>
>  monitor/avctp.c | 173 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 173 insertions(+)
>
> --
> 1.9.1

Applied, thanks.


-- 
Luiz Augusto von Dentz
