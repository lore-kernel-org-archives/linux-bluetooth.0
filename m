Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1424776660-27719-1-git-send-email-gowtham.ab@samsung.com>
References: <1424776660-27719-1-git-send-email-gowtham.ab@samsung.com>
Date: Tue, 24 Feb 2015 17:30:19 +0200
Message-ID: <CABBYNZLVBRA7fU1yPDvm2az31HFQxN0iLSmwEo_7G0Ti0C_xgw@mail.gmail.com>
Subject: Re: [PATCH 0/6] Add Write Characteristic Value client TC
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Bharat Panda <bharat.panda@samsung.com>, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gowtham,

On Tue, Feb 24, 2015 at 1:17 PM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:
> Adds the below client test cases:
> 1) Write Characteristic Value - by Client
> 2) Write Characteristic Value - Invalid Handle
> 3) Write Characteristic Value - Write Not Permitted
> 4) Write Characteristic Value - Insufficient Authorization
> 5) Write Characteristic Value - Insufficient Authentication
> 6) Write Characteristic Value - Insufficient Encryption Key Size
>
>
> Gowtham Anandha Babu (6):
>   unit/test-gatt: Add TP/GAW/CL/BV-03-C test
>   unit/test-gatt: Add TP/GAW/CL/BI-02-C test
>   unit/test-gatt: Add TP/GAW/CL/BI-03-C test
>   unit/test-gatt: Add TP/GAW/CL/BI-04-C test
>   unit/test-gatt: Add TP/GAW/CL/BI-05-C test
>   unit/test-gatt: Add TP/GAW/CL/BI-06-C test
>
>  unit/test-gatt.c | 108 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 106 insertions(+), 2 deletions(-)
>
> --
> 1.9.1

Applied, thanks.


-- 
Luiz Augusto von Dentz
