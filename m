Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 11.4 \(3445.8.2\))
Subject: Re: Determine ATT MTU size over DBUS
From: Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <ItIsS0qSiQBRm_d46ZW0jZvAxB9WABzkpJdr_ec5aYdLGTqb6S7s0ce8Z99SNylPJryv9oUnUgZDsDRBw5UjvPScF0QP4V5SWQmlUv14b7A=@krauser.org>
Date: Fri, 6 Jul 2018 19:14:49 +0200
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Message-Id: <9BF17FD6-F24F-4948-A3D0-3225A56BFA4B@holtmann.org>
References: <Vd5Hg1KzgalysaxK8wZu5wyXhzrIeNpwpHrqD6JzDGdK6926uwNchApKq9lnhrOPr7Y6Xb0Cgzzu-vWt8lvB-JRRxXhAmSPzjikGfg5kkSc=@krauser.org>
 <CABBYNZLHGQdpgZUGxaxhtWBG309WB9MVOXQxdRBWeMW+XuARBg@mail.gmail.com>
 <-JmTPP9qq2ljmysdKs_4nDqzQMZH4NMScqdEFmY7eo4Eu5GDniGqk-lMiLXCo7O1RZgB4BI_UsKZS0KdET69HZksuaRIKE_0mrQJS885K-M=@krauser.org>
 <2X21xsgg8bEyTVVoBik7GT2JM5chtujJdSSpMBd-J7xIRMuRPqnF8Or25Al9oNj5R08x57BAEhkOUdT1-8FEmtoGVKXOB7X1DTlLztKep-8=@krauser.org>
 <5401E5CE-7C2B-44D6-BF62-C98AC634F490@holtmann.org>
 <ItIsS0qSiQBRm_d46ZW0jZvAxB9WABzkpJdr_ec5aYdLGTqb6S7s0ce8Z99SNylPJryv9oUnUgZDsDRBw5UjvPScF0QP4V5SWQmlUv14b7A=@krauser.org>
To: David Krauser <david@krauser.org>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi David,

>> I prefer "mtu" as option name here. We kept them all lowercase. Other option is to use "max-transfer-unit".
> 
> I agree; however, the AcquireWrite and AcquireNotify already provide "MTU" as an option, and I figured it'd be better to be consistent with those. I could change those to be lowercase, but don't want to break existing users.

I prefer to fix it there as well then. We can deprecate that option.

Regards

Marcel

