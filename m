Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1428577891-3885-1-git-send-email-gowtham.ab@samsung.com>
References: <1428577891-3885-1-git-send-email-gowtham.ab@samsung.com>
Date: Fri, 10 Apr 2015 17:36:21 +0300
Message-ID: <CABBYNZLBZ_RPG9iL-b-vns7x5-KnfnAkU9pOxV8KXeJ0egLZVg@mail.gmail.com>
Subject: Re: [PATCH 0/6] Add Write Long Characteristic Descriptors client TC
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Bharat Panda <bharat.panda@samsung.com>, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gowtham,

On Thu, Apr 9, 2015 at 2:11 PM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:
> Adds the below client test cases:
> 1) Write Long Characteristic Descriptors – by Client
> 2) Write Long Characteristic Descriptors - Invalid Handle
> 3) Write Long Characteristic Descriptors - Write Not Permitted
> 4) Write Long Characteristic Descriptors - Insufficient Authorization
> 5) Write Long Characteristic Descriptors - Insufficient Authentication
> 6) Write Long Characteristic Descriptors - Insufficient Encryption Key Size
>
>
> Bharat Panda (2):
>   unit/test-gatt: Add TP/GAW/CL/BI-30-C test
>   unit/test-gatt: Add TP/GAW/CL/BI-31-C test
>
> Gowtham Anandha Babu (4):
>   unit/test-gatt: Add TP/GAW/CL/BV-09-C test
>   unit/test-gatt: Add TP/GAW/CL/BI-25-C test
>   unit/test-gatt: Add TP/GAW/CL/BI-26-C test
>   unit/test-gatt: Add TP/GAW/CL/BI-29-C test
>
>  unit/test-gatt.c | 304 +++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 304 insertions(+)
>
> --
> 1.9.1

Applied, thanks.


-- 
Luiz Augusto von Dentz
