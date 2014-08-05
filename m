Return-Path: <cyrus@holtmann.org>
Date: Tue, 5 Aug 2014 13:51:38 +0200
From: Antonio Ospite <ao2@ao2.it>
To: Vikrampal <vikram.pal@samsung.com>
Cc: 'Luiz Augusto von Dentz' <luiz.dentz@gmail.com>,
	linux-bluetooth@vger.kernel.org,
	'Dmitry Kasatkin' <d.kasatkin@samsung.com>
Subject: Re: AVCTP and AVRCP packet decoder file structure in btmon
Message-Id: <20140805135138.4d27987b16680f617c27582b@ao2.it>
In-Reply-To: <002f01cfb07a$2502c170$6f084450$@samsung.com>
References: <001301cfafc0$ef11b350$cd3519f0$@samsung.com>
	<CABBYNZKfvD271JoWqCW=Lupu-22scZRAJ0D8ksG8bXfUP8gBkg@mail.gmail.com>
	<002f01cfb07a$2502c170$6f084450$@samsung.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Tue, 05 Aug 2014 12:24:44 +0530
Vikrampal <vikram.pal@samsung.com> wrote:

> Sure Luiz!
> 
> However, I've one more small doubt. If I'm submitting a series of patches
> Such as 1/4, 2/4, 3/4, 4/4... I guess in such scenarios no need to ensure that
> the patches separately compiles. What we need to ensure is that all the patches together
> gets compiled properly. Am I mistaken?
> 

Make sure that sub-sequences of a series produce sensible code.

The code should $VALIDATE with 1/4 applied.
The code should $VALIDATE with 1/4 and 2/4 applied.
The code should $VALIDATE with 1/4, 2/4 and 3/4 applied.
The code should $VALIDATE with 1/4, 2/4, 3/4 and 4/4 applied.

The definition of VALIDATE can vary project by project or feature by
feature; the minimum requirement should be that compilation always
succeeds.

You can use something like:

	git rebase -i --exec "make" some_parent_branch

to test that compilation passes after each commit.

Ciao,
   Antonio

-- 
Antonio Ospite
http://ao2.it

A: Because it messes up the order in which people normally read text.
   See http://en.wikipedia.org/wiki/Posting_style
Q: Why is top-posting such a bad thing?
