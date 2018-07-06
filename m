Return-Path: <linux-bluetooth-owner@vger.kernel.org>
Date: Fri, 06 Jul 2018 09:34:01 -0400
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
From: David Krauser <david@krauser.org>
Reply-To: David Krauser <david@krauser.org>
Subject: Re: Determine ATT MTU size over DBUS
Message-ID: <ItIsS0qSiQBRm_d46ZW0jZvAxB9WABzkpJdr_ec5aYdLGTqb6S7s0ce8Z99SNylPJryv9oUnUgZDsDRBw5UjvPScF0QP4V5SWQmlUv14b7A=@krauser.org>
In-Reply-To: <5401E5CE-7C2B-44D6-BF62-C98AC634F490@holtmann.org>
References: <Vd5Hg1KzgalysaxK8wZu5wyXhzrIeNpwpHrqD6JzDGdK6926uwNchApKq9lnhrOPr7Y6Xb0Cgzzu-vWt8lvB-JRRxXhAmSPzjikGfg5kkSc=@krauser.org>
 <CABBYNZLHGQdpgZUGxaxhtWBG309WB9MVOXQxdRBWeMW+XuARBg@mail.gmail.com>
 <-JmTPP9qq2ljmysdKs_4nDqzQMZH4NMScqdEFmY7eo4Eu5GDniGqk-lMiLXCo7O1RZgB4BI_UsKZS0KdET69HZksuaRIKE_0mrQJS885K-M=@krauser.org>
 <2X21xsgg8bEyTVVoBik7GT2JM5chtujJdSSpMBd-J7xIRMuRPqnF8Or25Al9oNj5R08x57BAEhkOUdT1-8FEmtoGVKXOB7X1DTlLztKep-8=@krauser.org>
 <5401E5CE-7C2B-44D6-BF62-C98AC634F490@holtmann.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Marcel,

On July 6, 2018 6:25 AM, Marcel Holtmann <marcel@holtmann.org> wrote:
> I prefer "mtu" as option name here. We kept them all lowercase. Other opt=
ion is to use "max-transfer-unit".

I agree; however, the AcquireWrite and AcquireNotify already provide "MTU" =
as an option, and I figured it'd be better to be consistent with those. I c=
ould change those to be lowercase, but don't want to break existing users.

- dk
