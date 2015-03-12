Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1426078589-26354-1-git-send-email-gowtham.ab@samsung.com>
References: <1426078589-26354-1-git-send-email-gowtham.ab@samsung.com>
Date: Thu, 12 Mar 2015 19:25:36 +0200
Message-ID: <CABBYNZKTG6rkLxbssLPhyQTW=THW6fRVAQQxK08RFZejEOit0g@mail.gmail.com>
Subject: Re: [PATCH 0/3] Add Write Characteristic Descriptors TC
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Bharat Panda <bharat.panda@samsung.com>, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gowtham,

On Wed, Mar 11, 2015 at 2:56 PM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:
> Adds the below server test cases (tested against small and large DB):
> 1) Write Characteristic Descriptors – from Server
> 2) Write Characteristic Descriptor – Invalid Handle
> 3) Write Characteristic Descriptor – Write Not Permitted
>
> Gowtham Anandha Babu (3):
>   unit/test-gatt: Add TP/GAW/SR/BV-08-C test
>   unit/test-gatt: Add TP/GAW/SR/BI-20-C test
>   unit/test-gatt: Add TP/GAW/SR/BI-21-C test
>
>  unit/test-gatt.c | 36 ++++++++++++++++++++++++++++++++++++
>  1 file changed, 36 insertions(+)
>
> --
> 1.9.1

Applied, thanks.


-- 
Luiz Augusto von Dentz
