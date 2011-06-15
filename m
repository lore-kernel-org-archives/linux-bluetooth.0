Return-Path: <cyrus@holtmann.org>
Subject: Re: Per-project patch prefixes
From: Marcel Holtmann <marcel@holtmann.org>
To: "Gustavo F. Padovan" <padovan@profusion.mobi>
Cc: Vinicius Costa Gomes <vinicius.gomes@openbossa.org>,
	linux-bluetooth@vger.kernel.org
Date: Wed, 15 Jun 2011 04:10:28 -0700
In-Reply-To: <20110614213143.GD2613@joana>
References: <20110614211507.GB27437@piper> <20110614213143.GD2613@joana>
Content-Type: text/plain; charset="UTF-8"
Message-ID: <1308136231.2518.5.camel@aeonflux>
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Gustavo,

> > Now, this list receives patches for at least 3 different projects, so how
> > about using different subject prefixes for each priject? The first thing
> > that comes to mind is this:
> 
> This is a great idea. It can a lot when identifying patches, and you can do
> this to the project's .git/config:
> 
> [format]
>         subjectprefix = "bluetooth-next"

as long as patches come in as [PATCH bluetooth-next v2] or something
similar I am fine with this. I want the [PATCH ...] prefix kept alive
since that is one thing that git did right from the beginning.

Regards

Marcel


