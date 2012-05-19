Return-Path: <cyrus@holtmann.org>
Date: Sat, 19 May 2012 09:41:24 +0300
From: Johan Hedberg <johan.hedberg@gmail.com>
To: Paulo Alcantara <paulo.alcantara@openbossa.org>
Cc: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH BlueZ 1/2] storage: Store BLE address type in "primary"
 file
Message-ID: <20120519064124.GA27057@x220.P-661HNU-F1>
References: <1337374667-17802-1-git-send-email-paulo.alcantara@openbossa.org>
 <1337374667-17802-2-git-send-email-paulo.alcantara@openbossa.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1337374667-17802-2-git-send-email-paulo.alcantara@openbossa.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Paulo,

On Fri, May 18, 2012, Paulo Alcantara wrote:
> +static inline char ba_type2char(uint8_t bdaddr_type)
> +{
> +	switch (bdaddr_type) {
> +	case BDADDR_LE_PUBLIC:
> +		return '1';
> +	case BDADDR_LE_RANDOM:
> +		return '2';
> +	case BDADDR_BREDR:
> +	default:
> +		return '0';
> +	}
> +}
> +
>  int read_device_alias(const char *src, const char *dst, char *alias, size_t size)
>  {
>  	char filename[PATH_MAX + 1], *tmp;
> @@ -1162,17 +1175,22 @@ int write_blocked(const bdaddr_t *local, const bdaddr_t *remote,
>  }
>  
>  int write_device_services(const bdaddr_t *sba, const bdaddr_t *dba,
> -							const char *services)
> +			  uint8_t bdaddr_type, const char *services)
>  {
> -	char filename[PATH_MAX + 1], addr[18];
> +	char filename[PATH_MAX + 1], key[20];
>  
>  	create_filename(filename, PATH_MAX, sba, "primary");
>  
>  	create_file(filename, S_IRUSR | S_IWUSR | S_IRGRP | S_IROTH);
>  
> -	ba2str(dba, addr);
> +	memset(key, 0, sizeof(key));
>  
> -	return textfile_put(filename, addr, services);
> +	/* New format: address#type */
> +	ba2str(dba, key);
> +	key[17] = '#';
> +	key[18] = ba_type2char(bdaddr_type);

Wouldn't sprintf(&key[17], "#%hhu", bdaddr_type); be much simpler?

> +char *read_device_services(const bdaddr_t *sba, const bdaddr_t *dba,
> +							uint8_t bdaddr_type)
>  {
> -	char filename[PATH_MAX + 1], addr[18];
> +	char filename[PATH_MAX + 1], key[20];
>  
>  	create_filename(filename, PATH_MAX, sba, "primary");
>  
> -	ba2str(dba, addr);
> +	memset(key, 0, sizeof(key));
>  
> -	return textfile_caseget(filename, addr);
> +	/* New format: address#type */
> +	ba2str(dba, key);
> +	key[17] = '#';
> +	key[18] = ba_type2char(bdaddr_type);

Same here.

Johan
