Return-Path: <cyrus@holtmann.org>
Message-ID: <491302D7.5010408@nokia.com>
Date: Thu, 06 Nov 2008 16:44:39 +0200
From: Ville Tervo <ville.tervo@nokia.com>
MIME-Version: 1.0
To: ext Alok <alokbarsode@gmail.com>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: [PATCH] Netlink patch.
References: <1225979417.15398.13.camel@greatbear>
In-Reply-To: <1225979417.15398.13.camel@greatbear>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Alok,

ext Alok wrote:
> Hi Marcel, 
> 
> Attaching a patch which implements a generic netlink command
> GET_DEVLIST(HCIGETDEVLIST). 

I don't know anything about netlink stuff but I'll give some generic comments :)


+	
+	if (info->attrs[NLBLUETOOTH_ATTR_DEVNUM]) {
+		dev_num = nla_get_u16(info->attrs[NLBLUETOOTH_ATTR_DEVNUM]);
+		if (!dev_num)
+			return -EINVAL;
+	} else
+		return -EINVAL;
+

I would prefer this kind code paths. Easier to read.

	if (!info->attrs[NLBLUETOOTH_ATTR_DEVNUM])
		return -EINVAL;

	dev_num = nla_get_u16(info->attrs[NLBLUETOOTH_ATTR_DEVNUM]);
	if (!dev_num)
		return -EINVAL;

+	msg = nlmsg_new(NLMSG_GOODSIZE, GFP_KERNEL);
+
+	if (!msg)
+		return -ENOBUFS;
+
+	hdr = genlmsg_put(msg, 0, info->snd_seq+1, &nlbluetooth_fam, 0, NLBLUETOOTH_CMD_GET_DEVLIST);
+
+	if (hdr == NULL)
+		return -ENOMEM;

Is msg left unfreed here?

+
+	nl_list = nla_nest_start(msg, NLBLUETOOTH_ATTR_DEVLIST);
+	if (!nl_list)
+		goto nla_put_failure;

And here? I cannot find skb_free or friends from genlmsg_cancel() path.


-- 
Ville

