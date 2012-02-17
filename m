Return-Path: <cyrus@holtmann.org>
Date: Fri, 17 Feb 2012 11:54:14 +0200
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Mikel Astiz <mikel.astiz.oss@gmail.com>
Cc: linux-bluetooth@vger.kernel.org,
	Mikel Astiz <mikel.astiz@bmw-carit.de>
Subject: Re: [PATCH obexd v3 3/6] client: fix incorrect error check
Message-ID: <20120217095414.GB13492@x220>
References: <1329400834-8400-1-git-send-email-mikel.astiz.oss@gmail.com>
 <1329400834-8400-4-git-send-email-mikel.astiz.oss@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329400834-8400-4-git-send-email-mikel.astiz.oss@gmail.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Mikel,

On Thu, Feb 16, 2012, Mikel Astiz wrote:
> -	obc_session_setpath(pbap->session, path, pbap_setpath_cb, pbap, err);
> -	if (err != NULL) {
> +	if (obc_session_setpath(pbap->session, path, pbap_setpath_cb, pbap,
> +									err)) {

I know it adds a little bit of extra code, but I think it'd make this a
bit more readable if you added a new "guint id" variable and do:

	id = obc_session_setpath(...);
	if (id > 0) {
		...
	}

Johan
