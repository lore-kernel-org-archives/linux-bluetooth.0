Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain; charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: Re: [PATCH v6 3/3] Bluetooth: btqcomsmd: retrieve BD address from DT
 property
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAMZdPi8gSnS702LadCL7gRKzYbEtOBUZTYUrN1b_1wiycpC1gw@mail.gmail.com>
Date: Fri, 8 Sep 2017 12:57:40 +0200
Cc: Rob Herring <robh+dt@kernel.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org,
        devicetree <devicetree@vger.kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Message-Id: <61944931-B998-4349-A2B1-CAF6D5DD070C@holtmann.org>
References: <1504699898-28011-1-git-send-email-loic.poulain@linaro.org>
 <1504699898-28011-3-git-send-email-loic.poulain@linaro.org>
 <AD664D12-31A5-456B-9971-4A76BDC32BA3@holtmann.org>
 <CAMZdPi8gSnS702LadCL7gRKzYbEtOBUZTYUrN1b_1wiycpC1gw@mail.gmail.com>
To: Loic Poulain <loic.poulain@linaro.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Loic,

> > +     /* The local-bd-address property is usually injected by the
> > +      * bootloader which has access to the allocated BD address.
> > +      */
> > +     if (!of_property_read_u8_array(pdev->dev.of_node, "local-bd-address",
> > +                                    (u8 *)&btq->bdaddr, sizeof(bdaddr_t))) {
> > +             BT_INFO("BD address %pMR retrieved from device-tree",
> > +                     &btq->bdaddr);
> > +     }
> 
> any reason you are not using bt_dev_info here? I think it would be important to print the device information prefix.
> 
> Yes, hdev does not have any allocated name/number before being registered.
> I can move this after hci_register_dev if you prefer.

if that is possible, then that would be good.

Regards

Marcel

