Return-Path: <cyrus@holtmann.org>
Date: Thu, 25 Oct 2012 12:55:53 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: =?iso-8859-1?Q?Fr=E9d=E9ric?= Danis
	<frederic.danis@linux.intel.com>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH v7 16/16] hcitool: Retrieve names from cache directory
Message-ID: <20121025095553.GD24756@x220>
References: <1351089258-25179-1-git-send-email-frederic.danis@linux.intel.com>
 <1351089258-25179-17-git-send-email-frederic.danis@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1351089258-25179-17-git-send-email-frederic.danis@linux.intel.com>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Frédéric,

On Wed, Oct 24, 2012, Frédéric Danis wrote:
>  static char *get_device_name(const bdaddr_t *local, const bdaddr_t *peer)
>  {
> -	char filename[PATH_MAX + 1], addr[18];
> +	char filename[PATH_MAX + 1];
> +	char local_addr[18], peer_addr[18];
> +	GKeyFile *key_file;
> +	char *str = NULL;
> +	int len;
> +
> +	ba2str(local, local_addr);
> +	ba2str(peer, peer_addr);
> +
> +	snprintf(filename, PATH_MAX, STORAGEDIR "/%s/cache/%s", local_addr,
> +			peer_addr);
> +	filename[PATH_MAX] = '\0';
> +	key_file = g_key_file_new();
> +
> +	if (g_key_file_load_from_file(key_file, filename, 0, NULL)) {
> +		str = g_key_file_get_string(key_file, "General", "Name", NULL);
> +		if (str) {
> +			len = strlen(str);
> +			if (len > HCI_MAX_NAME_LENGTH)
> +				str[HCI_MAX_NAME_LENGTH] = '\0';
> +		}
> +	}
>  
> -	ba2str(local, addr);
> -	create_name(filename, PATH_MAX, STORAGEDIR, addr, "names");
> +	g_key_file_free(key_file);
>  
> -	ba2str(peer, addr);
> -	return textfile_get(filename, addr);
> +	return str;
>  }

This is the one exception where it's ok to directly go digging in the
cache, as we don't have the concept of btd_device in hcitool.

Johan
