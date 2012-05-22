Return-Path: <cyrus@holtmann.org>
Date: Tue, 22 May 2012 11:05:36 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Paulo Alcantara <paulo.alcantara@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v2 1/2] storage: Store BLE address type in
 "primary" file
Message-ID: <20120522080536.GB9688@x220>
References: <1337374667-17802-1-git-send-email-paulo.alcantara@openbossa.org>
 <1337633316-4992-1-git-send-email-paulo.alcantara@openbossa.org>
 <1337633316-4992-2-git-send-email-paulo.alcantara@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337633316-4992-2-git-send-email-paulo.alcantara@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Paulo,

On Mon, May 21, 2012, Paulo Alcantara wrote:
> +	/* New format: address#type */
> +	ba2str(dba, key);
> +	sprintf(&key[17], "#%hhu", bdaddr_type);

Since BlueZ 4.100 will be the first user space version being able to use
mgmtops with a kernel where mgmt is enabled by default (3.4) I don't
think we need to worry about old format vs new format, i.e. the code
comment above is unnecessary.

> +	/* New format: address#type */
> +	ba2str(dba, key);
> +	sprintf(&key[17], "#%hhu", bdaddr_type);
> +
> +	str = textfile_caseget(filename, key);
> +	if (str != NULL)
> +		return str;
> +
> +	/* Old format: address only */
> +	key[17] = '\0';
> +
> +	return textfile_caseget(filename, key);

Same thing here. I think we can leave out any code that tries to work
with the old storage format since we can consider LE support as
experimental/unstable in all previous user space releases.

Johan
