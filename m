Return-Path: <cyrus@holtmann.org>
Date: Wed, 5 May 2010 17:02:02 +0200
From: Stefan Seyfried <stefan.seyfried@googlemail.com>
To: Fabian Greffrath <fabian@greffrath.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: Detect invalid (i.e. non-UTF-8) device names and fix them
 during initialization phase
Message-ID: <20100505170202.3d6b1dcb@susi.home.s3e.de>
In-Reply-To: <4BE14819.4080903@greffrath.com>
References: <4BE14458.1020908@greffrath.com>
	<4BE14819.4080903@greffrath.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Wed, 05 May 2010 12:27:37 +0200
Fabian Greffrath <fabian@greffrath.com> wrote:

> Dear Bluez list,
> 
> I am sorry, I know this is the worst way to start getting in touch 
> with a software project, but I accidently attached the wrong patch to 
> my previous email. It's configure_device() that must be patched. 
> Please find a corrected patch attached (it has been written against 
> bluez 4.63 but applies perfectly against 4.64).

I have one questions about the code from a cursory look (hint:
sending the patch inline would help commenting on it)

* where does the 249 in "char name[249];" come from? Is it from the BT
  spec? Or from somewhere else? A comment in the code might help. (If this
  is a number from the spec that is used all over the same code file and
  explained elsewhere, this question is obviously moot)

Then it would probably good if you could send the patch against current
git (even if it still applies cleanly) and in a format that "git am" can
process directly. That makes it very easy for the maintainers to apply the
code and in the same run makes sure you get proper attribution for your
contribution ;)

Have fun,

	Stefan
-- 
Stefan Seyfried

"Any ideas, John?"
"Well, surrounding them's out."
