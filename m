Received: from mail-lj1-f182.google.com (mail-lj1-f182.google.com [209.85.208.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0602227055B;
	Thu,  8 May 2025 15:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746718245; cv=none; b=FyI1ug3vRj2PncJvAlbwkW84+KnCyMVM5C9tgXgSQqsEbY7FQGQHcVl+yztdXmPVWi7QoCSee0t1GBqA+PFIg0hBkjjpzmuVuwpIHi3gF6uRGDGl5rZqSgRxUqphGObPlmLVhby2Pecn4S5LMowaGSS+znzNIqcus3MWRxjK1PM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746718245; c=relaxed/simple;
	bh=uhQvp9WCPff1pqcCLJ4XswGJ3RxMU2XJRgqdUNXRyVA=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Fu2GRC5fYbcj1RRtXtBTNTbB3hXoxv2kHiU0iG75tmAum1v72Q+UXzvxgqcaWNGj00dC/Zv3NkGXc6tEMpliyC93LBvVp04zJWC1Qxg2cAKHJZgEXkl/XEJPj0kAfKKR1t8iWpqDf9WUKRDOZhdcrgUx/JgS6jmmiKqWuzw4XuM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=AW/37OWG; arc=none smtp.client-ip=209.85.208.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="AW/37OWG"
Received: by mail-lj1-f182.google.com with SMTP id 38308e7fff4ca-3105ef2a08dso9637231fa.0;
        Thu, 08 May 2025 08:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1746718242; x=1747323042; darn=vger.kernel.org;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QQjzfkiPY/mQYrchxkE0D0BYClorMNWbaJFsccheq+I=;
        b=AW/37OWGBs7QCFjyZ4zgHJ9svOrOBIr/QIEmZ7dvLo9ZfUpguAE/QDBiXpbqGFdxXx
         w+779dWlEQL+r7f242tmZ04eUF5vXSGD/r875fGx7cS0KIcgV034fsjwwZtp4c0M11Y+
         al3dD0yxjgGLiZ1KIqtpbKZxV6XkE0kc3W32NBa70FlX8ABat87Rd89imoCX+Wtpe3Ov
         JX34e8JJH1MhFm8RgVaO5jjjCSPGZWadXck7+8CRKQ4Jd3Wli7iM4cVHYQS55Ah4R1u2
         6nxHR4Kro5/XU8o6hlwDSpayHLj3kfB7YM6FCzUK4tlqT8uIu28m1CwoRpQhcXt/EKGf
         N1WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746718242; x=1747323042;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QQjzfkiPY/mQYrchxkE0D0BYClorMNWbaJFsccheq+I=;
        b=ssnhMjV88spyqaDJzkhKezM7flnBiLc3DemLJ8X8u3/EZcQK5MDem9ShENEASp7N/1
         +BYwM2naAsVJ5gl8XxXW6vifC1DsWkOVfcqQcOMql/tTIAya6hhCw9fwBR1LZXo/hDIG
         3pXmVD0XL/c0S7Lx63Ot7UUsNfyXrvRnGPvJBlL7+9N+ui9I11aXLXmYsDzSXK7a1GRO
         cvv8y1HntsZqISZGAI6+JzyC7ZzJilPWpyjkFbAMTxbGSio1pmptmL4Lxx65rhpMiVol
         EF9adJT/LOv7TfWPMGGkjZ2HoeeIdCbmV8h3JUsQ9LtI8hyl22OgxiFnlGCLt6ZmP5XP
         B9hg==
X-Forwarded-Encrypted: i=1; AJvYcCU48mJrQnJZxL0ZQt3vmIzzuJiv0R51Travvxr05DGcH6EaCacDrJcMyhQJFxtI2Y0Z1/6YkozJt8lSqfM0Jn0=@vger.kernel.org, AJvYcCWNdPhPN6WOBZkNCGV6CU+YdU7sDps0mmuTxBGe/6V7bFUfc0Rf7COHxjHdiCFd810H/JJaOQygZBAUCjGS@vger.kernel.org
X-Gm-Message-State: AOJu0Yx/uJCId+NbJDKmnRyicdtoCO0ZB031jQTa7A/UbgdQTsKwLEW9
	acdX8dIzYT+y4w8jdGitSAaBhbPqpPIpw4I9aBRPg0v//iM6pja+sFrXNOzPyK4FK5txmMWaZNj
	0zK8yMhIgbUIUUTXiqGV2Ww7F9+Q=
X-Gm-Gg: ASbGnctOZ9hYZXX9iZBkulQ6/3ZtSs1xMVBqIfzQ2HToRQP4KMtVKFS9mptrFSXhhcj
	ztmsK/7k47q7ZlSBj1jqtbS0o9KTIhcMokg2YZJOCg2alkScRkCb0rthqtaL2JJvkMZv5fGCdp/
	TAQjlqx7i+1IBeCEL5i5Gs
X-Google-Smtp-Source: AGHT+IF/61wqEt/gNK9h/BFue8pEMVVs+3WwaDDUV5ZgMtO8p13iaJh7NeacXgRZn557ZpoAf4I6UX8O9Cp1YbR3BlM=
X-Received: by 2002:a2e:a596:0:b0:30b:d17b:26aa with SMTP id
 38308e7fff4ca-326b87cf07fmr14365951fa.2.1746718240194; Thu, 08 May 2025
 08:30:40 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20250507-iso-v1-1-6f60d243e037@amlogic.com> <202505081427.1Y3wyo7v-lkp@intel.com>
In-Reply-To: <202505081427.1Y3wyo7v-lkp@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 8 May 2025 11:30:27 -0400
X-Gm-Features: ATxdqUGPfxuIy0MdHoQ0PVbw6pgnv1cWGOpJhgK1DoiY8DK67Jpr4Z0Jh949-eo
Message-ID: <CABBYNZKfz1J8YY9Atj935NJ7KoyHpUgPpUNGz_CytffNBXJfRQ@mail.gmail.com>
Subject: Re: [PATCH] Bluetooth: fix socket matching ambiguity between BIS and CIS
To: kernel test robot <lkp@intel.com>
Cc: Yang Li via B4 Relay <devnull+yang.li.amlogic.com@kernel.org>, 
	Marcel Holtmann <marcel@holtmann.org>, Johan Hedberg <johan.hedberg@gmail.com>, 
	oe-kbuild-all@lists.linux.dev, linux-bluetooth@vger.kernel.org, 
	linux-kernel@vger.kernel.org, Yang Li <yang.li@amlogic.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Thu, May 8, 2025 at 2:54=E2=80=AFAM kernel test robot <lkp@intel.com> wr=
ote:
>
> Hi Yang,
>
> kernel test robot noticed the following build errors:
>
> [auto build test ERROR on f3daca9b490154fbb0459848cc2ed61e8367bddc]
>
> url:    https://github.com/intel-lab-lkp/linux/commits/Yang-Li-via-B4-Rel=
ay/Bluetooth-fix-socket-matching-ambiguity-between-BIS-and-CIS/20250507-153=
347
> base:   f3daca9b490154fbb0459848cc2ed61e8367bddc
> patch link:    https://lore.kernel.org/r/20250507-iso-v1-1-6f60d243e037%4=
0amlogic.com
> patch subject: [PATCH] Bluetooth: fix socket matching ambiguity between B=
IS and CIS
> config: i386-allmodconfig (https://download.01.org/0day-ci/archive/202505=
08/202505081427.1Y3wyo7v-lkp@intel.com/config)
> compiler: gcc-12 (Debian 12.2.0-14) 12.2.0
> reproduce (this is a W=3D1 build): (https://download.01.org/0day-ci/archi=
ve/20250508/202505081427.1Y3wyo7v-lkp@intel.com/reproduce)
>
> If you fix the issue in a separate patch/commit (i.e. not just a new vers=
ion of
> the same patch/commit), kindly add following tags
> | Reported-by: kernel test robot <lkp@intel.com>
> | Closes: https://lore.kernel.org/oe-kbuild-all/202505081427.1Y3wyo7v-lkp=
@intel.com/
>
> All errors (new ones prefixed by >>):
>
>    net/bluetooth/hci_event.c: In function 'hci_le_per_adv_report_evt':
> >> net/bluetooth/hci_event.c:6469:60: error: 'ISO_LINK' undeclared (first=
 use in this function); did you mean 'SCO_LINK'?
>     6469 |         mask |=3D hci_proto_connect_ind(hdev, &pa_sync->dst, I=
SO_LINK, &flags);
>          |                                                            ^~~=
~~~~~
>          |                                                            SCO=
_LINK
>    net/bluetooth/hci_event.c:6469:60: note: each undeclared identifier is=
 reported only once for each function it appears in
>    net/bluetooth/hci_event.c: In function 'hci_le_big_info_adv_report_evt=
':
>    net/bluetooth/hci_event.c:7055:60: error: 'ISO_LINK' undeclared (first=
 use in this function); did you mean 'SCO_LINK'?
>     7055 |         mask |=3D hci_proto_connect_ind(hdev, &pa_sync->dst, I=
SO_LINK, &flags);
>          |                                                            ^~~=
~~~~~
>          |                                                            SCO=
_LINK
>
>
> vim +6469 net/bluetooth/hci_event.c
>
>   6449
>   6450  static void hci_le_per_adv_report_evt(struct hci_dev *hdev, void =
*data,
>   6451                                        struct sk_buff *skb)
>   6452  {
>   6453          struct hci_ev_le_per_adv_report *ev =3D data;
>   6454          int mask =3D hdev->link_mode;
>   6455          __u8 flags =3D 0;
>   6456          struct hci_conn *pa_sync;
>   6457
>   6458          bt_dev_dbg(hdev, "sync_handle 0x%4.4x", le16_to_cpu(ev->s=
ync_handle));
>   6459
>   6460          hci_dev_lock(hdev);
>   6461
>   6462          pa_sync =3D hci_conn_hash_lookup_pa_sync_handle
>   6463                          (hdev,
>   6464                          le16_to_cpu(ev->sync_handle));
>   6465
>   6466          if (!pa_sync)
>   6467                  goto unlock;
>   6468
> > 6469          mask |=3D hci_proto_connect_ind(hdev, &pa_sync->dst, ISO_=
LINK, &flags);
>   6470          if (!(mask & HCI_LM_ACCEPT))
>   6471                  goto unlock;
>   6472
>   6473          if (!(flags & HCI_PROTO_DEFER))
>   6474                  goto unlock;
>   6475
>   6476          if (ev->data_status =3D=3D LE_PA_DATA_COMPLETE &&
>   6477              !test_and_set_bit(HCI_CONN_PA_SYNC, &pa_sync->flags))=
 {
>   6478                  /* Notify iso layer */
>   6479                  hci_connect_cfm(pa_sync, 0);
>   6480
>   6481                  /* Notify MGMT layer */
>   6482                  mgmt_device_connected(hdev, pa_sync, NULL, 0);
>   6483          }
>   6484
>   6485  unlock:
>   6486          hci_dev_unlock(hdev);
>   6487  }
>   6488
>
> --
> 0-DAY CI Kernel Test Service
> https://github.com/intel/lkp-tests/wiki

This is probably already solved by:

https://github.com/bluez/bluetooth-next/commit/f3daca9b490154fbb0459848cc2e=
d61e8367bddc

--=20
Luiz Augusto von Dentz
