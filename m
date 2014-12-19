Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1418817585-26816-1-git-send-email-gowtham.ab@samsung.com>
References: <1418817585-26816-1-git-send-email-gowtham.ab@samsung.com>
Date: Fri, 19 Dec 2014 11:01:45 -0200
Message-ID: <CABBYNZKp+g72uSoHrAduYAfGpHX69Fmcv6_FbQZ9aKeR-d-2Vw@mail.gmail.com>
Subject: Re: [PATCH 0/2] rfcomm: Add Test command decoding implementation
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Dmitry Kasatkin <d.kasatkin@samsung.com>,
	Bharat Panda <bharat.panda@samsung.com>, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gowtham,

On Wed, Dec 17, 2014 at 9:59 AM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:
> Add support for decoding RFCOMM Test command in
> monitor and tools/parser.
>
> Gowtham Anandha Babu (2):
>   monitor/rfcomm: Add support for decoding Test command
>   parser/rfcomm: Add support for decoding Test command
>
>  monitor/rfcomm.c      | 19 +++++++++++++++++++
>  tools/parser/rfcomm.c | 12 +++++++++++-
>  2 files changed, 30 insertions(+), 1 deletion(-)
>
> --
> 1.9.1

Applied, thanks.


-- 
Luiz Augusto von Dentz
