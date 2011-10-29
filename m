Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1319806804-12230-3-git-send-email-dh.herrmann@googlemail.com>
References: <1319806804-12230-1-git-send-email-dh.herrmann@googlemail.com>
	<1319806804-12230-3-git-send-email-dh.herrmann@googlemail.com>
Date: Sat, 29 Oct 2011 18:40:12 +0200
Message-ID: <CANq1E4TDPiK18jDobqjrVYf60tHT0++8u384F_rOq3BWXK0FMA@mail.gmail.com>
Subject: Re: [RFC 2/4] Bluetooth: Fix hci-sysfs ref-counts
From: David Herrmann <dh.herrmann@googlemail.com>
To: linux-bluetooth@vger.kernel.org
Cc: marcel@holtmann.org, padovan@profusion.mobi,
	David Herrmann <dh.herrmann@googlemail.com>
Content-Type: text/plain; charset=ISO-8859-1
List-ID: <linux-bluetooth.vger.kernel.org>

On 10/28/11, David Herrmann <dh.herrmann@googlemail.com> wrote:
> When registering a device object we need to take a module reference so
> the device-destruct function is available when the object is freed.
>
> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
> ---
>  include/net/bluetooth/hci_core.h |    2 +-
>  net/bluetooth/hci_core.c         |    6 +++++-
>  net/bluetooth/hci_sysfs.c        |    8 +++++++-
>  3 files changed, 13 insertions(+), 3 deletions(-)
>
> diff --git a/include/net/bluetooth/hci_core.h
> b/include/net/bluetooth/hci_core.h
> index 13a62ad..c8368a5 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -580,7 +580,7 @@ int hci_recv_frame(struct sk_buff *skb);
>  int hci_recv_fragment(struct hci_dev *hdev, int type, void *data, int
> count);
>  int hci_recv_stream_fragment(struct hci_dev *hdev, void *data, int count);
>
> -void hci_init_sysfs(struct hci_dev *hdev);
> +int hci_init_sysfs(struct hci_dev *hdev);
>  int hci_add_sysfs(struct hci_dev *hdev);
>  void hci_del_sysfs(struct hci_dev *hdev);
>  void hci_conn_init_sysfs(struct hci_conn *conn);
> diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
> index daa948f..20c3c97 100644
> --- a/net/bluetooth/hci_core.c
> +++ b/net/bluetooth/hci_core.c
> @@ -912,7 +912,11 @@ struct hci_dev *hci_alloc_dev(void)
>  	if (!hdev)
>  		return NULL;
>
> -	hci_init_sysfs(hdev);
> +	if (hci_init_sysfs(hdev)) {
> +		kfree(hdev);
> +		return NULL;
> +	}
> +
>  	skb_queue_head_init(&hdev->driver_init);
>
>  	return hdev;
> diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
> index 116401a..605cb2b 100644
> --- a/net/bluetooth/hci_sysfs.c
> +++ b/net/bluetooth/hci_sysfs.c
> @@ -78,6 +78,7 @@ static void bt_link_release(struct device *dev)
>  {
>  	void *data = dev_get_drvdata(dev);
>  	kfree(data);
> +	module_put(THIS_MODULE);
>  }

Ok I messed up. This needs to be inside bt_host_release and not
bt_link_release, of course. Then everything works fine.

>  static struct device_type bt_link = {
> @@ -540,15 +541,20 @@ static int auto_accept_delay_get(void *data, u64 *val)
>  DEFINE_SIMPLE_ATTRIBUTE(auto_accept_delay_fops, auto_accept_delay_get,
>  					auto_accept_delay_set, "%llu\n");
>
> -void hci_init_sysfs(struct hci_dev *hdev)
> +int hci_init_sysfs(struct hci_dev *hdev)
>  {
>  	struct device *dev = &hdev->dev;
>
> +	if (!try_module_get(THIS_MODULE))
> +		return -EIO;
> +
>  	dev->type = &bt_host;
>  	dev->class = bt_class;
>
>  	dev_set_drvdata(dev, hdev);
>  	device_initialize(dev);
> +
> +	return 0;
>  }
>
>  int hci_add_sysfs(struct hci_dev *hdev)
> --
> 1.7.7.1
>
>
