Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1443709943-29957-1-git-send-email-gowtham.ab@samsung.com>
References: <1443709943-29957-1-git-send-email-gowtham.ab@samsung.com>
Date: Fri, 2 Oct 2015 10:33:31 +0300
Message-ID: <CABBYNZLWTwfGDzeCcRRgpkb0ZA3F5qtzPYBG2uLpYJo1xexFjA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Use tester framework
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
To: Gowtham Anandha Babu <gowtham.ab@samsung.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>,
	Bharat Panda <bharat.panda@samsung.com>
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gowtham,

On Thu, Oct 1, 2015 at 5:32 PM, Gowtham Anandha Babu
<gowtham.ab@samsung.com> wrote:
> Remove mainloop and use tester framework to
> produces much better output.
>
> Gowtham Anandha Babu (3):
>   unit/test-hfp: Use tester framework
>   unit/test-sdp: Use tester framework
>   unit/test-uhid: Use tester framework
>
>  unit/test-hfp.c  | 91 +++++++++++++++++++++++++++-----------------------------
>  unit/test-sdp.c  | 91 +++++++++++++++++++++++++-------------------------------
>  unit/test-uhid.c | 62 ++++++++++++++++----------------------
>  3 files changed, 110 insertions(+), 134 deletions(-)
>
> --
> 1.9.1

Applied, thanks.


-- 
Luiz Augusto von Dentz
