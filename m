Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1427374752-26053-1-git-send-email-gowtham.ab@samsung.com>
References: <1427374752-26053-1-git-send-email-gowtham.ab@samsung.com>
Date: Fri, 27 Mar 2015 16:37:13 +0200
Message-ID: <CABBYNZJk4enaxKhGcg7MU5ojC82XxSNfCkbuCXP_UhH5xW69Mw@mail.gmail.com>
Subject: Re: [PATCH 0/7] Add Write Long Characteristic Value client TC
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Bharat Panda <bharat.panda@samsung.com>, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gowtham,

On Thu, Mar 26, 2015 at 2:59 PM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:
> Adds the below client test cases:
> 1) Write Long Characteristic Value - by Client
> 2) Write Long Characteristic Value - Invalid Handle
> 3) Write Long Characteristic Value - Write Not Permitted
> 4) Write Long Characteristic Value - Insufficient Authorization
> 5) Write Long Characteristic Value - Insufficient Authentication
> 6) Write Long Characteristic Value - Insufficient Encryption Key Size
>
> Gowtham Anandha Babu (7):
>   unit/test-gatt: Add TP/GAW/CL/BV-05-C test
>   unit/test-gatt: Add TP/GAW/CL/BI-07-C test
>   unit/test-gatt: Add TP/GAW/CL/BI-08-C test
>   unit/test-gatt: Add TP/GAW/CL/BI-11-C test
>   unit/test-gatt: Add TP/GAW/CL/BI-12-C test
>   unit/test-gatt: Add TP/GAW/CL/BI-13-C test
>   shared/gatt-client: Add const qualifier to prepare write value
>
>  src/shared/gatt-client.c |   2 +-
>  src/shared/gatt-client.h |   2 +-
>  unit/test-gatt.c         | 331 ++++++++++++++++++++++++++++++++++++++++++++++-
>  3 files changed, 330 insertions(+), 5 deletions(-)
>
> --
> 1.9.1

Applied, thanks.


-- 
Luiz Augusto von Dentz
