Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1425362846-16580-1-git-send-email-gowtham.ab@samsung.com>
References: <1425362846-16580-1-git-send-email-gowtham.ab@samsung.com>
Date: Tue, 3 Mar 2015 11:20:49 +0200
Message-ID: <CABBYNZKn4XzzMtYbzVCvzVb0MWexjnThF_xzYVSRUnoun_CY3w@mail.gmail.com>
Subject: Re: [PATCH v1 0/3] Add Write Characteristic Value server TC
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Bharat Panda <bharat.panda@samsung.com>, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gowtham,

On Tue, Mar 3, 2015 at 8:07 AM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:
> Adds the below server test cases (tested against small and large DB):
> 1) Write Characteristic Value - to Server
> 2) Write Characteristic Value – Invalid Handle Response
> 3) Write Characteristic Value – Write Not Permitted Response
>
> Bharat Panda (2):
>   unit/test-gatt: Add TP/GAW/SR/BI-02-C test
>   unit/test-gatt: Add TP/GAW/SR/BI-03-C test
>
> Gowtham Anandha Babu (1):
>   unit/test-gatt: Add TP/GAW/SR/BV-03-C test
>
>  unit/test-gatt.c | 42 ++++++++++++++++++++++++++++++------------
>  1 file changed, 30 insertions(+), 12 deletions(-)
>
> --
> 1.9.1

Applied after rewording the commit message.


-- 
Luiz Augusto von Dentz
