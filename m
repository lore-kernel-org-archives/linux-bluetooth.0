Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1415375018-21866-2-git-send-email-gowtham.ab@samsung.com>
References: <1415375018-21866-1-git-send-email-gowtham.ab@samsung.com>
	<1415375018-21866-2-git-send-email-gowtham.ab@samsung.com>
Date: Mon, 10 Nov 2014 11:07:36 +0200
Message-ID: <CABBYNZLfsndufv5BhJZnfzG51vPhhsgqdconsiPRzpfsgW5RjA@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Add support for RFCOMM in btmon
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Dmitry Kasatkin <d.kasatkin@samsung.com>,
	Bharat Panda <bharat.panda@samsung.com>, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gowtham,

On Fri, Nov 7, 2014 at 5:43 PM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:
> Adds an initial implementation for RFCOMM in Bluetooth monitor.
>
> Implementation for Decoding MSC, RPN, RLS, PN, NSC frames
> will  be covered in the next patch-set.
>
> *v1: Incorporated Johan comments.
>
> *v2: changed FCS fetching by l2cap_frame_pull
>
> Gowtham Anandha Babu (4):
>   monitor/rfcomm: Add RFCOMM support to btmon
>   monitor/rfcomm: Add support for printing RFCOMM hdr
>   monitor/rfcomm: Add support for UIH frame decoding
>   monitor/rfcomm: Add support for mcc frame decoding
>
>  Makefile.tools     |   1 +
>  android/Android.mk |   1 +
>  monitor/l2cap.c    |   4 +
>  monitor/l2cap.h    |   2 +
>  monitor/rfcomm.c   | 275 +++++++++++++++++++++++++++++++++++++++++++++++++++++
>  5 files changed, 283 insertions(+)
>  create mode 100644 monitor/rfcomm.c
>
> --
> 1.9.1

Applied, thanks.


-- 
Luiz Augusto von Dentz
