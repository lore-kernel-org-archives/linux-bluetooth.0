Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1327679246-2667-4-git-send-email-dh.herrmann@googlemail.com>
References: <1327679246-2667-1-git-send-email-dh.herrmann@googlemail.com>
	<1327679246-2667-4-git-send-email-dh.herrmann@googlemail.com>
Date: Fri, 27 Jan 2012 19:01:30 +0200
Message-ID: <CAMXE1-odnk+eVKjmz2jsZS0-Nj93RnVe4mmGL0y6cWjfrw4CPg@mail.gmail.com>
Subject: Re: [PATCH 3/4] Bluetooth: Introduce to_hci_conn
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: David Herrmann <dh.herrmann@googlemail.com>
Cc: johan.hedberg@gmail.com, marcel@holtmann.org,
	linux-bluetooth@vger.kernel.org
Content-Type: multipart/alternative; boundary=20cf303f65a0c4266904b7857270
List-ID: <linux-bluetooth.vger.kernel.org>

--20cf303f65a0c4266904b7857270
Content-Type: text/plain; charset=ISO-8859-1

Hi David,

> This avoids using the dev_set/get_drvdata() functions to retrieve a
> pointer to our own structure. We can use simple pointer arithmetic here.
> The drvdata field is actually not needed by any other code-path but this
> makes the code more consistent with hci_dev.
>
> Signed-off-by: David Herrmann <dh.herrmann@googlemail.com>
> ---
>  include/net/bluetooth/hci_core.h |    1 +
>  net/bluetooth/hci_sysfs.c        |   10 ++++------
>  2 files changed, 5 insertions(+), 6 deletions(-)
>
> diff --git a/include/net/bluetooth/hci_core.h
b/include/net/bluetooth/hci_core.h
> index 9780f42..8784da1 100644
> --- a/include/net/bluetooth/hci_core.h
> +++ b/include/net/bluetooth/hci_core.h
> @@ -612,6 +612,7 @@ static inline struct hci_dev *hci_dev_hold(struct
hci_dev *d)
>  #define hci_dev_unlock(d)      mutex_unlock(&d->lock)
>
>  #define to_hci_dev(d) container_of(d, struct hci_dev, dev)
> +#define to_hci_conn(c) container_of(c, struct hci_conn, dev)
>
>  static inline void *hci_get_drvdata(struct hci_dev *hdev)
>  {
> diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c
> index 2a0243a..17e6cd4 100644
> --- a/net/bluetooth/hci_sysfs.c
> +++ b/net/bluetooth/hci_sysfs.c
> @@ -33,19 +33,19 @@ static inline char *link_typetostr(int type)
>
>  static ssize_t show_link_type(struct device *dev, struct
device_attribute *attr, char *buf)
>  {
> -       struct hci_conn *conn = dev_get_drvdata(dev);
> +       struct hci_conn *conn = to_hci_conn(dev);

I personally think it was more readable before.

--Andrei

--20cf303f65a0c4266904b7857270
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

<p>Hi David,<br></p>
<p>&gt; This avoids using the dev_set/get_drvdata() functions to retrieve a=
<br>
&gt; pointer to our own structure. We can use simple pointer arithmetic her=
e.<br>
&gt; The drvdata field is actually not needed by any other code-path but th=
is<br>
&gt; makes the code more consistent with hci_dev.<br>
&gt;<br>
&gt; Signed-off-by: David Herrmann &lt;<a href=3D"mailto:dh.herrmann@google=
mail.com">dh.herrmann@googlemail.com</a>&gt;<br>
&gt; ---<br>
&gt; =A0include/net/bluetooth/hci_core.h | =A0 =A01 +<br>
&gt; =A0net/bluetooth/hci_sysfs.c =A0 =A0 =A0 =A0| =A0 10 ++++------<br>
&gt; =A02 files changed, 5 insertions(+), 6 deletions(-)<br>
&gt;<br>
&gt; diff --git a/include/net/bluetooth/hci_core.h b/include/net/bluetooth/=
hci_core.h<br>
&gt; index 9780f42..8784da1 100644<br>
&gt; --- a/include/net/bluetooth/hci_core.h<br>
&gt; +++ b/include/net/bluetooth/hci_core.h<br>
&gt; @@ -612,6 +612,7 @@ static inline struct hci_dev *hci_dev_hold(struct =
hci_dev *d)<br>
&gt; =A0#define hci_dev_unlock(d) =A0 =A0 =A0mutex_unlock(&amp;d-&gt;lock)<=
br>
&gt;<br>
&gt; =A0#define to_hci_dev(d) container_of(d, struct hci_dev, dev)<br>
&gt; +#define to_hci_conn(c) container_of(c, struct hci_conn, dev)<br>
&gt;<br>
&gt; =A0static inline void *hci_get_drvdata(struct hci_dev *hdev)<br>
&gt; =A0{<br>
&gt; diff --git a/net/bluetooth/hci_sysfs.c b/net/bluetooth/hci_sysfs.c<br>
&gt; index 2a0243a..17e6cd4 100644<br>
&gt; --- a/net/bluetooth/hci_sysfs.c<br>
&gt; +++ b/net/bluetooth/hci_sysfs.c<br>
&gt; @@ -33,19 +33,19 @@ static inline char *link_typetostr(int type)<br>
&gt;<br>
&gt; =A0static ssize_t show_link_type(struct device *dev, struct device_att=
ribute *attr, char *buf)<br>
&gt; =A0{<br>
&gt; - =A0 =A0 =A0 struct hci_conn *conn =3D dev_get_drvdata(dev);<br>
&gt; + =A0 =A0 =A0 struct hci_conn *conn =3D to_hci_conn(dev);</p>
<p>I personally think it was more readable before.</p>
<p>--Andrei <br>
</p>

--20cf303f65a0c4266904b7857270--
