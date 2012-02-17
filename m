Return-Path: <cyrus@holtmann.org>
Date: Fri, 17 Feb 2012 11:56:36 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [PATCH obexd v3 6/6] client: queue transfers in pbap sessions
Message-ID: <20120217095636.GC13492@x220>
References: <1329400834-8400-1-git-send-email-mikel.astiz.oss@gmail.com>
 <1329400834-8400-7-git-send-email-mikel.astiz.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329400834-8400-7-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Thu, Feb 16, 2012, Mikel Astiz wrote:
> +struct pending_request *pending_request_new(struct pbap_data *pbap,
> +						DBusMessage *message)
> +{
> +	struct pending_request *p;
> +
> +	p = g_new0(struct pending_request, 1);
> +	p->pbap = pbap;
> +	p->msg = dbus_message_ref(message);
> +
> +	return p;
> +}

This will cause a compilation warning/error since you're not exporting
the function through any .h file. I suppose you intended to declare it
static? Also, this implies that you're not doing compilation tests with
./bootstrap-configure since it converts all warnings to errors and would
have made it impossible to compile the code. Please always use that when
writing new code.

Johan
