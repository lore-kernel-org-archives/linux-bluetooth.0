Return-Path: <cyrus@holtmann.org>
MIME-Version: 1.0
In-Reply-To: <1251885004.1266.57.camel@localhost.localdomain>
References: <508e92ca0907020657o561effbeg1911f8f84af27f37@mail.gmail.com>
	 <1251885004.1266.57.camel@localhost.localdomain>
Date: Thu, 3 Sep 2009 12:55:02 +0300
Message-ID: <508e92ca0909030255g3dfd825dy5062458c7a5cafcb@mail.gmail.com>
Subject: Re: [PATCH] SSP double paring fix: init auth_type with
	HCI_AT_GENERAL_BONDING
From: Andrei Emeltchenko <andrei.emeltchenko.news@gmail.com>
To: Marcel Holtmann <marcel@holtmann.org>
Cc: linux-bluetooth@vger.kernel.org
Content-Type: multipart/mixed; boundary=0016e6482b269ec0830472a9605f
List-ID: <linux-bluetooth.vger.kernel.org>

--0016e6482b269ec0830472a9605f
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable

Hi Marcel,

On Wed, Sep 2, 2009 at 12:50 PM, Marcel Holtmann<marcel@holtmann.org> wrote=
:
> Hi Andrei,
>
>> I have a simple patch which fixes issues with SSP mentioned below.
>>
>> ---
>> =A0net/bluetooth/hci_conn.c | =A0 =A01 +
>> =A01 files changed, 1 insertions(+), 0 deletions(-)
>>
>> diff --git a/net/bluetooth/hci_conn.c b/net/bluetooth/hci_conn.c
>> index fa47d5d..d863bda 100644
>> --- a/net/bluetooth/hci_conn.c
>> +++ b/net/bluetooth/hci_conn.c
>> @@ -211,6 +211,7 @@ struct hci_conn *hci_conn_add(struct hci_dev
>> *hdev, int type, bdaddr_t *dst)
>> =A0 =A0 =A0 conn->type =A0=3D type;
>> =A0 =A0 =A0 conn->mode =A0=3D HCI_CM_ACTIVE;
>> =A0 =A0 =A0 conn->state =3D BT_OPEN;
>> + =A0 =A0 conn->auth_type =3D HCI_AT_GENERAL_BONDING;
>>
>> =A0 =A0 =A0 conn->power_save =3D 1;
>> =A0 =A0 =A0 conn->disc_timeout =3D HCI_DISCONN_TIMEOUT;
>
> I need a proper patch create with git format-patch that contains a
> detailed commit message.

Please check patch attached.

Regards,
Andrei

--0016e6482b269ec0830472a9605f
Content-Type: application/x-gzip;
	name="0001-Bluetooth-Set-general-bonding-security-for-ACL-by-d.patch.gz"
Content-Disposition: attachment;
	filename="0001-Bluetooth-Set-general-bonding-security-for-ACL-by-d.patch.gz"
Content-Transfer-Encoding: base64
X-Attachment-Id: f_fz5bm32w0

H4sICAqSn0oAAzAwMDEtQmx1ZXRvb3RoLVNldC1nZW5lcmFsLWJvbmRpbmctc2VjdXJpdHktZm9y
LUFDTC1ieS1kLnBhdGNoAJ1T0XKbOhB9vvqKfWxqgwHTYDu3nTiOk3imsTPXtC+dO4yEFqMbkDxI
xHGnH9/FjpP70j6UYQSc3T17dFbcNKaGuAiT+EMuhMjHcRGFSYQ8HuH5MAnCZDQSkZSRGMkh3BsN
a9xCmEAQTA43REEQshuimcBUywYVzGusXF6ifjTwNz9gPr5hvsadvdzUXFV+bupP7Jo7nEBatn0Y
HuiJcgxhNBnGk3AMvWAYBGzdiv8wdxP49jBNZ3f/wlXVojPGlROqcbBBjQ2vQBgtld6AxbxtlNtD
YRqYzj6D2IPEgreVYywtlYUtJ0FQqGe0IE0rKiRINV2xsrYldKdcCev1g8/YwsGOWzDCYvOEElzJ
CaH9vNackkGQsO/A7aOF3OhCNTV3ymgWgVM1Wp+Vzm0ng8Fut/PtVmmVW7LEDSplnaVVt8+eOG1u
UNtNEMXJ0C9dXb0o55U1kPPWkkbRbo46dgjE5RSZeZBBvTUZRp2h6Ib8lei53zEgNMgt4UQl8MAD
rw0leUG02jiwzjQIJOgRHnFvwSqdI1MmdxXA3WxxO0+nX9K7xfJmRYyubbSFwO+m4TpDXtw+TYad
JnN03JVIbY9Gk6q12miUnikKT+z/+CR5nseg8/LNvzJXWWeFn8MPoCuEHqOlUBWJyEuuNyj7BChN
k+3csu96Z30ISH6Fx2/vjDGpigI8b6Mc8MEvO4hfhpjSEp+Bj5MPwXjk+yLJ4yiKIQyC8zjuhP+G
l/V6vd9xX16CF4Vh/xx63SMBAqxr2tzBKQven94yLuW7/0UlPlGQ1j554MDtt9gHISmryRy8l9ad
Mfirq/Q+dUGAj4eki1e0NvKA0pHIZvfZdJYuvs7fwnTs6Eh+hKs0Wz3Mlxes9xLgrSuzA+Wxdppm
t/Pl/J/p5+xqtbxeLG+J5JVma3bYZJY/denhG71UNs+6P8u07oXoerGerZbLLF3cz1df0guyF1jo
n/uBHzP2E7ePQMzzBAAA
--0016e6482b269ec0830472a9605f--
