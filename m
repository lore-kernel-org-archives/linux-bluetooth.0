Return-Path: <cyrus@holtmann.org>
Date: Thu, 5 Jul 2012 13:41:42 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Paulo Alcantara <paulo.alcantara@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ v2 02/12] storage: Store address type in "aliases"
 file
Message-ID: <20120705104141.GA27842@x220.ger.corp.intel.com>
References: <1339715044-13737-1-git-send-email-paulo.alcantara@openbossa.org>
 <1341347535-15343-1-git-send-email-paulo.alcantara@openbossa.org>
 <1341347535-15343-3-git-send-email-paulo.alcantara@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1341347535-15343-3-git-send-email-paulo.alcantara@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Paulo,

On Tue, Jul 03, 2012, Paulo Alcantara wrote:
>  int delete_entry(bdaddr_t *src, const char *storage, const char *key)
>  {
> -	char filename[PATH_MAX + 1];
> +	char filename[PATH_MAX + 1], old_key[18];
> +	int err;
> +
> +	memset(old_key, 0, sizeof(old_key));
> +	memcpy(old_key, key, sizeof(old_key) - 1);
>  
>  	create_filename(filename, PATH_MAX, src, storage);
>  
> -	return textfile_del(filename, key);
> +	/* key: address#type */
> +	err = textfile_del(filename, key);
> +	if (err < 0)
> +		/* old_key: address only */
> +		err = textfile_del(filename, old_key);
> +
> +	return err;
>  }

This looks dangerous to me. Even though the only users of delete_entry()
use addresses as the key values there's nothing about the naming of this
function that suggests that it's only usable for key values with a very
specific format compared to what the rest of storage.c is designed to
support (arbitrary key values).

Either the function name and/or the "key" parameter name needs to be
changed to make this restricted use clear or then the error handling of
old keys should be pushed to the caller side (device.c).

Johan
