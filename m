Return-Path: <cyrus@holtmann.org>
Message-ID: <20110617121950.13306qfj8egbctc0@mail.hendrik-sattler.de>
Date: Fri, 17 Jun 2011 12:19:50 +0200
From: Hendrik Sattler <post@hendrik-sattler.de>
To: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH obexd 2/4] Add basic support for action commands on ftp
 driver
References: <1308292007-2111-1-git-send-email-luiz.dentz@gmail.com>
 <1308292007-2111-2-git-send-email-luiz.dentz@gmail.com>
In-Reply-To: <1308292007-2111-2-git-send-email-luiz.dentz@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=ISO-8859-1;
 DelSp="Yes";
 format="flowed"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Zitat von Luiz Augusto von Dentz <luiz.dentz@gmail.com>:
> +static char *ftp_build_filename(struct ftp_session *ftp, const char  
> *destname)
> +{
> +	char *filename;
> +
> +	/* DestName can either be relative or absolute (FTP style) */
> +	if (g_path_is_absolute(destname))
> +		filename = g_build_filename(destname, NULL);
> +	else
> +		filename = g_build_filename(ftp->folder, destname, NULL);
> +
> +	/* Check if destination is inside root path */
> +	if (g_str_has_prefix(filename, ftp->folder))
> +		return filename;
> +
> +	g_free(filename);
> +
> +	return NULL;
> +}

Except that this interprets the destination header in a wrong way:
Absolute destination means that it is based on the path that you  
export to the _client_ as root, not the local filesystem root.

You should also catch stuff like the UNC path stuff and drive letter  
prefixes. No need to support all the sick stuff :-/

HS


