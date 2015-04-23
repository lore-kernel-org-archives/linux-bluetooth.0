Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1429607669-30669-1-git-send-email-gowtham.ab@samsung.com>
References: <1429607669-30669-1-git-send-email-gowtham.ab@samsung.com>
Date: Thu, 23 Apr 2015 18:37:21 +0300
Message-ID: <CABBYNZK3NqLdnzb=XcjgdQ6pumLEZyeBZy3LW5r23=DPtwSYKg@mail.gmail.com>
Subject: Re: [PATCH 0/5] Add decoding for BNEP packet types
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Bharat Panda <bharat.panda@samsung.com>, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gowtham,

On Tue, Apr 21, 2015 at 12:14 PM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:
> Gowtham Anandha Babu (5):
>   monitor: Add support for decoding bnep General pkt
>   monitor: Add support for decoding bnep Control pkt
>   monitor: Add support for decoding bnep Compressed pkt
>   monitor: Add support for decoding bnep SrcOnly pkt
>   monitor: Add support for decoding bnep DestOnly pkt
>
>  monitor/bnep.c | 179 +++++++++++++++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 169 insertions(+), 10 deletions(-)
>
> --
> 1.9.1

Applied, thanks.


-- 
Luiz Augusto von Dentz
