Return-Path: <cyrus@holtmann.org>
Date: Sun, 21 Nov 2010 15:14:42 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Jose Antonio Santos Cadenas <santoscadenas@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Remove parameter entered from the DisplayPasskey agent
 method
Message-ID: <20101121131442.GA22320@jh-x301>
References: <1290343578-986-1-git-send-email-santoscadenas@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1290343578-986-1-git-send-email-santoscadenas@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Jose,

On Sun, Nov 21, 2010, Jose Antonio Santos Cadenas wrote:
> In the current method implementation the parameter is not used.
> ---
>  doc/agent-api.txt |    5 +----
>  1 files changed, 1 insertions(+), 4 deletions(-)

Do you actually have a BT 2.1 keyboard to test this with? The right fix
is to fix the code and not the spec since we do want the UI to get the
hints about entered characters.

Johan
