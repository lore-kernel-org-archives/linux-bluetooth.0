Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1380291161-10232-15-git-send-email-Andrei.Emeltchenko.news@gmail.com>
References: <1380291161-10232-1-git-send-email-Andrei.Emeltchenko.news@gmail.com>
	<1380291161-10232-15-git-send-email-Andrei.Emeltchenko.news@gmail.com>
Date: Fri, 27 Sep 2013 13:59:34 -0400
Message-ID: <CAJdJm_Pzi4gpqby=TJHhrB7W0yXqy2Cy9qttq0ePHdj3L54-Zg@mail.gmail.com>
Subject: Re: [RFC 14/16] android: Handle mgmt changed events
From: Anderson Lizardo <anderson.lizardo@openbossa.org>
To: Andrei Emeltchenko <Andrei.Emeltchenko.news@gmail.com>
Cc: BlueZ development <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset=ISO-8859-1
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Andrei,

On Fri, Sep 27, 2013 at 10:12 AM, Andrei Emeltchenko
<Andrei.Emeltchenko.news@gmail.com> wrote:
> +static void mgmt_dev_class_changed_event(uint16_t index, uint16_t length,
> +                                       const void *param, void *user_data)
> +{
> +       struct bt_adapter *adapter = user_data;
> +       const struct mgmt_cod *rp = param;
> +       uint8_t appearance[3];
> +       uint32_t dev_class;
> +
> +       if (length < sizeof(*rp)) {
> +               error("Wrong size of class of device changed parameters");
> +               return;
> +       }
> +
> +       dev_class = rp->val[0] | (rp->val[1] << 8) | (rp->val[2] << 16);
> +
> +       if (dev_class == adapter->dev_class)
> +               return;
> +
> +       DBG("Class: 0x%06x", dev_class);
> +
> +       adapter->dev_class = dev_class;
> +
> +       /* TODO: Inform prop change: Class */
> +
> +       appearance[0] = rp->val[0];
> +       appearance[1] = rp->val[1] & 0x1f;  /* removes service class */
> +       appearance[2] = rp->val[2];
> +
> +       /* TODO: Gatt attrib set*/
> +       (void)appearance;

While it is clear this is incomplete code, doing things like above
just to silence the compiler looks bad. better simply remove the
"appearance" variable (adding it later when you implement GAP
Appearance) and replace it with a TODO or print the value with a
DBG().

Best Regards,
-- 
Anderson Lizardo
Instituto Nokia de Tecnologia - INdT
Manaus - Brazil
