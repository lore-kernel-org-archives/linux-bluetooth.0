Return-Path: <cyrus@holtmann.org>
Message-ID: <49F87CFF.4090804@pook.es>
Date: Wed, 29 Apr 2009 18:14:55 +0200
From: Stuart Pook <linux-bluetooth4@pook.es>
MIME-Version: 1.0
To: Stuart Pook <linux-bluetooth4@pook.es>,
	linux-bluetooth@vger.kernel.org
Subject: Re: bluetoothd 4.37 -> Segmentation fault
References: <49F8638C.5070205@pook.es> <20090429160430.GA25611@jh-x301>
In-Reply-To: <20090429160430.GA25611@jh-x301>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

hi Johan

Johan Hedberg wrote:

> It'd be good if you could get a trace with debug symbols so we see the
> exact line numbers.

Why don't I have debug symbols? Does the default make not add debug symbols? I guess that I'll have to look at how I call configure.

> However, before that could you check with latest git
> if you still experience this crash.

Do I have to update the client plugins as well or can I mix a bluetoothd from git with the plugins from 4.37?

> There's at least one commit since
> 4.37 (7fb4d906c00bf6e2ed03cc3e880bab52b8a984d6) that fixes a crash issue
> with client_free.

Should I always try the git version before reporting bugs?

Stuart
