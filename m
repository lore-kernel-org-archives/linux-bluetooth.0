Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1425546818-23258-1-git-send-email-gowtham.ab@samsung.com>
References: <1425546818-23258-1-git-send-email-gowtham.ab@samsung.com>
Date: Thu, 5 Mar 2015 14:01:09 +0200
Message-ID: <CABBYNZ+=omnJdiqBFc7JxDWXPAAVetAphq3y1PUNm=By=z4Ouw@mail.gmail.com>
Subject: Re: [PATCH 0/7] Add Write Characteristic Descriptor TCs
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Bharat Panda <bharat.panda@samsung.com>, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gowtham,

On Thu, Mar 5, 2015 at 11:13 AM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:
> Adds the below client test cases (tested against service db):
> 1) Write Characteristic Descriptors – by Client
> 2) Write Characteristic Descriptor – Invalid Handle
> 3) Write Characteristic Descriptor – Write Not Permitted
> 4) Write Characteristic Descriptor – Insufficient Authorization
> 5) Write Characteristic Descriptor – Insufficient Authentication
> 6) Write Characteristic Descriptor – Insufficient Encryption Key Size
>
> and updated the test-gatt count in doc/test-coverage.
>
> Gowtham Anandha Babu (7):
>   unit/test-gatt: Add TP/GAW/CL/BV-08-C test
>   unit/test-gatt: Add TP/GAW/CL/BI-20-C test
>   unit/test-gatt: Add TP/GAW/CL/BI-21-C test
>   unit/test-gatt: Add TP/GAW/CL/BI-22-C test
>   unit/test-gatt: Add TP/GAW/CL/BI-23-C test
>   unit/test-gatt: Add TP/GAW/CL/BI-24-C test
>   doc/test-coverage: Update test-gatt count
>
>  doc/test-coverage.txt |  5 +--
>  unit/test-gatt.c      | 84 +++++++++++++++++++++++++++++++++++++++++++++++++++
>  2 files changed, 87 insertions(+), 2 deletions(-)
>
> --
> 1.9.1

Applied, thank.


-- 
Luiz Augusto von Dentz
