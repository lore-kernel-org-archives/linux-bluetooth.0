Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1417608081-27926-1-git-send-email-gowtham.ab@samsung.com>
References: <1417608081-27926-1-git-send-email-gowtham.ab@samsung.com>
Date: Thu, 4 Dec 2014 14:17:07 +0200
Message-ID: <CABBYNZK-yPUsenN=CFcJ3Juaw7+GSGTHr-PWM6rq7i73iM3aQA@mail.gmail.com>
Subject: Re: [PATCH v1 0/5] Add support for decoding RFCOMM MCC Message Type
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Dmitry Kasatkin <d.kasatkin@samsung.com>,
	Bharat Panda <bharat.panda@samsung.com>, cpgs@samsung.com
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gowtham,

On Wed, Dec 3, 2014 at 2:01 PM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:
> *v1: Removed the break signal decoding implementation for now.
>
> This patch set implements the handlers for decoding
> MSC, RPN, RLS, PN, NSC frames for RFCOMM in bluetooth
> monitor.
>
> Gowtham Anandha Babu (5):
>   monitor/rfcomm.c: Add support for MSC frame decoding
>   monitor/rfcomm: Add support for RPN frame decoding
>   monitor/rfcomm: Add support for RLS frame decoding
>   monitor/rfcomm: Add support for PN frame decoding
>   monitor/rfcomm: Add support for NSC frame decoding
>
>  monitor/rfcomm.c | 233 +++++++++++++++++++++++++++++++++++++++++++++++++++++--
>  1 file changed, 226 insertions(+), 7 deletions(-)
>
> --
> 1.9.1

Applied, thanks.


-- 
Luiz Augusto von Dentz
