Return-Path: <cyrus@holtmann.org>
Date: Sat, 9 Oct 2010 18:23:41 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Anderson Lizardo <anderson.lizardo@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Add support for Attribute Write Request
Message-ID: <20101009152341.GA18538@jh-x301>
References: <1286474561-23905-1-git-send-email-anderson.lizardo@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1286474561-23905-1-git-send-email-anderson.lizardo@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Anderson,

On Thu, Oct 07, 2010, Anderson Lizardo wrote:
> Implement encoders/decoders for Write Request/Response and the handling
> on attribute server. The attribute client still uses the Write Command
> because currently SetProperty() has no means to wait for the server
> response.
> ---
>  attrib/att.c        |   50 ++++++++++++++++++++++++++++++++++++++++++++++++++
>  attrib/att.h        |    4 ++++
>  attrib/gatt.c       |   11 +++++++++++
>  attrib/gatt.h       |    3 +++
>  src/attrib-server.c |   12 +++++++++++-
>  5 files changed, 79 insertions(+), 1 deletions(-)

Thanks. The patch is now upstream.

Johan
