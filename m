Return-Path: <cyrus@holtmann.org>
Date: Fri, 2 Dec 2011 13:23:42 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Bartosz Szatkowski <bulislaw@linux.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 1/4] Add basic support for MAP client in obex-client
Message-ID: <20111202112342.GA17203@x220.ger.corp.intel.com>
References: <1321973198-23091-1-git-send-email-bulislaw@linux.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1321973198-23091-1-git-send-email-bulislaw@linux.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Bartosz,

On Tue, Nov 22, 2011, Bartosz Szatkowski wrote:
> +Messages Access hierarchy
> +=========================
> +
> +Service		org.openobex.client
> +Interface	org.openobex.MessagesAccess

Could we call this just Message Access (i.e. in singular form) since
that's what the profile is called too.

Johan
