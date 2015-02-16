Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1423838900-18110-1-git-send-email-bharat.panda@samsung.com>
References: <1423838900-18110-1-git-send-email-bharat.panda@samsung.com>
Date: Mon, 16 Feb 2015 14:22:43 +0200
Message-ID: <CABBYNZ+59x_Zz2uG1qDUrO9u7dC2AztJqUCPzFxamTXtRgu3ww@mail.gmail.com>
Subject: Re: [PATCH 0/6] Add Read Characteristic Descriptors test cases
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Bharat Panda <bharat.panda@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	cpgs@samsung.com, Gowtham Anandha Babu <gowtham.ab@samsung.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bharat,

On Fri, Feb 13, 2015 at 4:48 PM, Bharat Panda <bharat.panda@samsung.com> wrote:
> This patch-set adds the GATT client unit test cases for,
>
> 1) Read Characteristic Descriptors by Client
> 2) Read Characteristic Descriptors - Read Not Permitted
> 3) Read Characteristic Descriptors - Invalid Handle]
> 4) Read Characteristic Descriptors - Insufficient Authorization
> 5) Read Characteristic Descriptors - Insufficient Authentication
> 6) Read Characteristic Descriptors - Insufficient Encryption Key Size
>
> Bharat Panda (3):
>   unit/gatt: Add TP/GAR/CL/BI-25-C test
>   unit/gatt: Add TP/GAR/CL/BI-26-C test
>   unit/gatt: Add TP/GAR/CL/BI-27-C test
>
> Gowtham Anandha Babu (3):
>   unit/gatt: Add /TP/GAR/CL/BV-06-C test
>   unit/gatt: Add TP/GAR/CL/BI-23-C test
>   unit/gatt: Add TP/GAR/CL/BI-24-C test
>
>  unit/test-gatt.c | 68 ++++++++++++++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 68 insertions(+)
>
> --
> 1.9.1

Applied, thanks.


-- 
Luiz Augusto von Dentz
