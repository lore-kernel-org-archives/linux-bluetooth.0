Return-Path: <cyrus@holtmann.org>
Sender: "Gustavo F. Padovan" <pao@profusion.mobi>
Date: Mon, 4 Apr 2011 19:00:02 -0300
From: "Gustavo F. Padovan" <padovan@profusion.mobi>
To: Alexey Dobriyan <adobriyan@gmail.com>
Cc: marcel@holtmann.org, linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] kstrtox: convert net/bluetooth/
Message-ID: <20110404220002.GF2230@joana>
References: <20110402111941.GB19357@p183.telecom.by>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20110402111941.GB19357@p183.telecom.by>
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alexey,

* Alexey Dobriyan <adobriyan@gmail.com> [2011-04-02 14:19:41 +0300]:

> Convert from strict_strto*() interfaces to kstrto*() interfaces.
> 
> Signed-off-by: Alexey Dobriyan <adobriyan@gmail.com>
> ---
> 
>  net/bluetooth/hci_sysfs.c |   37 +++++++++++++++++--------------------
>  1 file changed, 17 insertions(+), 20 deletions(-)
> 
> --- a/net/bluetooth/hci_sysfs.c
> +++ b/net/bluetooth/hci_sysfs.c
> @@ -277,11 +277,12 @@ static ssize_t show_idle_timeout(struct device *dev, struct device_attribute *at
>  static ssize_t store_idle_timeout(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
>  {
>  	struct hci_dev *hdev = dev_get_drvdata(dev);
> -	unsigned long val;
> -
> -	if (strict_strtoul(buf, 0, &val) < 0)
> -		return -EINVAL;
> +	unsigned int val;
> +	int rv;
>  
> +	rv = kstrtouint(buf, 0, &val);
> +	if (rv < 0)
> +		return rv;

Add a empty line here, please.

>  	if (val != 0 && (val < 500 || val > 3600000))
>  		return -EINVAL;
>  
> @@ -299,15 +300,13 @@ static ssize_t show_sniff_max_interval(struct device *dev, struct device_attribu
>  static ssize_t store_sniff_max_interval(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
>  {
>  	struct hci_dev *hdev = dev_get_drvdata(dev);
> -	unsigned long val;
> -
> -	if (strict_strtoul(buf, 0, &val) < 0)
> -		return -EINVAL;
> -
> -	if (val < 0x0002 || val > 0xFFFE || val % 2)
> -		return -EINVAL;
> +	u16 val;
> +	int rv;
>  
> -	if (val < hdev->sniff_min_interval)
> +	rv = kstrtou16(buf, 0, &val);
> +	if (rv < 0)
> +		return rv;
> +	if (val == 0 || val % 2 || val < hdev->sniff_min_interval)
>  		return -EINVAL;

Why are you changing other things besides the string conversions? The checks
for val should stay the same.

>  
>  	hdev->sniff_max_interval = val;
> @@ -324,15 +323,13 @@ static ssize_t show_sniff_min_interval(struct device *dev, struct device_attribu
>  static ssize_t store_sniff_min_interval(struct device *dev, struct device_attribute *attr, const char *buf, size_t count)
>  {
>  	struct hci_dev *hdev = dev_get_drvdata(dev);
> -	unsigned long val;
> -
> -	if (strict_strtoul(buf, 0, &val) < 0)
> -		return -EINVAL;
> -
> -	if (val < 0x0002 || val > 0xFFFE || val % 2)
> -		return -EINVAL;
> +	u16 val;
> +	int rv;
>  
> -	if (val > hdev->sniff_max_interval)
> +	rv = kstrtou16(buf, 0, &val);
> +	if (rv < 0)
> +		return rv;
> +	if (val == 0 || val % 2 || val > hdev->sniff_max_interval)
>  		return -EINVAL;

Same problem here.


-- 
Gustavo F. Padovan
http://profusion.mobi
