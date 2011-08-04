Return-Path: <cyrus@holtmann.org>
Message-ID: <4E3A82D0.7060003@start.ca>
Date: Thu, 04 Aug 2011 07:30:24 -0400
From: Colin Beckingham <colbec@start.ca>
MIME-Version: 1.0
To: linux-bluetooth@vger.kernel.org
Subject: Re: Permission denied (13) on Samsung WEP475 headset?
References: <4E3A7E09.6040503@start.ca>
In-Reply-To: <4E3A7E09.6040503@start.ca>
Content-Type: multipart/mixed;
 boundary="------------040100090405040909000703"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a multi-part message in MIME format.
--------------040100090405040909000703
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit



On 08/04/2011 07:10 AM, Colin Beckingham wrote:
> I'd like to provide some feedback regarding a Samsung WEP475 headset
> which fails to connect to linux specifically.
>
> The USB bluetooth adapter is a Model: Belkin BLUETOOTH USB +EDR ADAPTER
> v2.1 UHE which successfully interconnects with 2 Jabra and 1 Plantronics
> headsets, plus a Nokia E71 phone. Samsung WEP475 successfully connects
> to a Windows XP machine and to the Nokia E71.
>
> Using Opensuse 11.4 with custom kernel 3.0 currently, (also fails with
> 2.6.38), bluez 4.96 and bluedevil manager.
>
> Symptoms are that bluedevil sees the headset in pairing mode and
> correctly retrieves the name WEP475, connected button flashes green and
> then returns to grey (not connected). WEP475 led changes to connected
> status but bluedevil shows headset not connected and headset does not work.
>
> With bluetoothd in debug mode, I get the following transactions in
> /var/log/messages:
>
> Aug 4 06:22:51 linux-xxxx bluetoothd[13227]:
> plugins/hciops.c:conn_complete() status 0x00
> Aug 4 06:22:51 linux-xxxx bluetoothd[13227]:
> src/adapter.c:adapter_get_device() 00:---:47
> Aug 4 06:22:51 linux-xxxx bluetoothd[13227]:
> plugins/hciops.c:remote_features_information() hci0 status 0
> Aug 4 06:22:51 linux-xxxx bluetoothd[13227]:
> plugins/hciops.c:remote_name_information() hci0 status 0
> Aug 4 06:22:51 linux-xxxx bluetoothd[13227]:
> audio/headset.c:headset_set_channel() Discovered Handsfree service on
> channel 2
> Aug 4 06:22:51 linux-xxxx bluetoothd[13227]:
> audio/headset.c:rfcomm_connect() /org/bluez/13226/hci0/dev_00_---_47:
> Connecting to 00:---:47 channel 2
> Aug 4 06:22:51 linux-xxxx bluetoothd[13227]:
> plugins/hciops.c:link_key_request() hci0 dba 00:---:47
> Aug 4 06:22:51 linux-xxxx bluetoothd[13227]:
> plugins/hciops.c:get_auth_info() hci0 dba 00:---:47
> Aug 4 06:22:51 linux-xxxx bluetoothd[13227]:
> plugins/hciops.c:link_key_request() kernel auth requirements = 0x04
> Aug 4 06:22:51 linux-xxxx bluetoothd[13227]:
> plugins/hciops.c:link_key_request() Matching key found
> Aug 4 06:22:51 linux-xxxx bluetoothd[13227]:
> plugins/hciops.c:link_key_request() link key type 0x04
> Aug 4 06:22:51 linux-xxxx bluetoothd[13227]:
> plugins/hciops.c:auth_complete() hci0 status 0
> Aug 4 06:22:51 linux-xxxx bluetoothd[13227]:
> plugins/hciops.c:bonding_complete() status 0x00
> Aug 4 06:22:51 linux-xxxx bluetoothd[13227]:
> src/event.c:btd_event_bonding_complete() status 0x00
> Aug 4 06:22:51 linux-xxxx bluetoothd[13227]:
> src/adapter.c:adapter_get_device() 00:---:47
> Aug 4 06:22:51 linux-xxxx bluetoothd[13227]:
> src/device.c:device_bonding_complete() bonding (nil) status 0x00
> Aug 4 06:22:52 linux-xxxx bluetoothd[13227]: Permission denied (13)
> Aug 4 06:22:52 linux-xxxx bluetoothd[13227]:
> audio/headset.c:headset_set_state() State changed
> /org/bluez/13226/hci0/dev_00_---_47: HEADSET_STATE_CONNECTING ->
> HEADSET_STATE_DISCONNECTED
> Aug 4 06:22:52 linux-xxxx bluetoothd[13227]:
> plugins/hciops.c:disconn_complete() handle 11 status 0x00
> Aug 4 06:22:52 linux-xxxx bluetoothd[13227]:
> src/event.c:btd_event_disconn_complete()
> Aug 4 06:22:52 linux-xxxx bluetoothd[13227]:
> src/adapter.c:adapter_remove_connection()
>
> I have tried clearing the contents of /var/lib/bluetooth/ forcing the
> system to recreate, but no difference.

Attached is hcidump

-- 
---
Colin Beckingham

--------------040100090405040909000703
Content-Type: application/x-gzip;
 name="btdump.tar.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="btdump.tar.gz"

H4sIAHOBOk4AA+1bbW/bNhDu5/yKA/ahyYcWpN5tFAMa10GCNU7QtBiGYRhoiUqEyJIqUWky
7MfvqBdHsmVbzmut6QDbcizdPffweDwe26lw0ln0XtyKN88mhBBD0wA/qakT+Ulo/l2Kqpsq
BUoNauiE6MQAQlVNMd4AeT5I95ImgsUIxQ59L1h7H4+TNb/nzsD8c0fkF7iyPRkCsHc8OoEk
8FyXx/AODv2UizAUVxAx+5oLYAHz7/7B327wpbwnew6/8Ww+lAoIPsiiv30eDIESxQLX8wWP
h0Bu3QXZ+wDS0CiczVjgDOEk+J568R3sk1tC/8U3DI4DiFAV6HuA4rMI1Qy4NVVVkH+2IEhn
QPZ+zRSNb3gghqU+uBBMpEmmzS3UaJmaZjtJfrv8CoE9c4DW1Y5vBQ8c7swf/8KT1BdSi1Lq
V/Qc6NRhjhMDIUPyaTg2hsZ4qNOhZsIsdDhQsP3r0HUTpBIfnpou/oEl0rZCiEY0iJPEg3cm
yZShP6hccPBDm/kQsBky/fb38blm6m/rd2BgyoHI1fFEkk4psbIPyl/bH4t2y5+ujY9pdcyf
rsWb+eoIOsaoMeiWP6bWMX+Mjvljdsufzs0ftVv+7Oz48P9HBWnsasW1anyUHfVn1fjsar7u
2vis8qdjO7CdjbdV62nX4q1j9fXzxlvpxvzhrOFWOJKv5JWm22I3cBRzhs+MwiDgtvDCoNqv
00st6no2InEXcVRv29RCn394wr6S1uoEyTZtpuc872/Kh4bw6ZTiS8WXDp+O8foYr4912LLb
uMmPTX3H4sE6i2rp/xKNcIVofAwBupqVjJSPo8/AAzu+i0Qj/184c/BtFqLJizSKwlhgaB6h
M2nMk4oTdFrGZoZlbn9Lnrayt4m0FsqmLSjMfimfkrE+tWUfW0aU5ZZXdFpe6QP5g7qOyfkc
b3LMLiCpdSIhYpd8OSy24HOT1W3obNSlqPUJ2RyQuR8wY7ewTC3Oyez2tW/L1GaYJpix8Pp7
yhNRdW1QoiItkqaynBO2ZXwTmM081zTU57y5sARUla30TOby+1S+wN7HVFyhXc9mWV4qMOPQ
VlDTJ5ncLS1t4uezF1zDb/yuSi8teTHWjvGi70uqJvwSwd1I4iO/djhktzPQyEhtBHk9HLeD
UPDRduQXluIzGLGITT3fEzX2VPog9pr1LcJWyhw7WD/97HtVWR4Iw2nuHMOwkVdFW2Z+Gy7O
XhL57O4PnkxC2D87OwSHCQZBKCDChIJOHzQEHj7HHXmNkXcYBo4XXML+6cnXUziPceJly/PB
9gPZno0nHcQkCoMkA6QqDyFaXSZaWSJ6Ep4EUSom4Vkq8PORXONgraf7GxaYsuRxvXhWyxWZ
m2rLfB5hcXqNE0uzrMFS7K42sTRizzXzt4PwqKC58CQMrGy9WI5AFZVqFKjMB+qeJ7BJKDy3
TO4yJ1vlqrGhPpeDZJhHmmkeqoOxcqSYA/XwaKyMBmNdNwz8NqZ5uZqvI1+zyvxbwO5DjWdU
T70gt45w6iBlVNYHw6iVWc2F30LMXHBRreDHed1cL+apuqJ8q1TZ266bbe1u/McLBYQRorrM
WbBqhpoLthryJywePmS7D5lFhhVrrs8uCwhOMVlerspYC0gpAOV+fFZGH8/3kwO5w3VD3FZG
wzxGFYjzHXs+WUHOC0jK7Udbr5W2aIwFNOVOMQPk2J6TadUIJJXrAiGZs1BArURZkto2TxI3
9V8CsutdIqjvdcQVC/b9+AKcfv0GhgZtcVltcWkrcEkmk2ZccyIzgCWNFzl3LQEqWkuARaMm
B+ggwAqm7HcV/oySGZC/2lo22lq2NljWumdZU9dbVgdzyzu6PZmksymWIKE7XxmdovmV5dX5
UqYvdSLye6xtArzfFvXbomfcFj02lluv/tr6rEBJc1bot23bbtsMXTHIoP2+bWWCUJwX38Ct
xfLiOzl9tW554ziOw3iplD9inp/G/KHbKH2hf76FEUxfNtahdTt6i41KzFmCSuXdZfM7kbG8
wmh/1NQfNfVHTf1R00901PRMLZEHnkl1txtC+25I3w1p7Ay84Dnsk+5flJ9eXZsx1Qfrx1TX
K2Pan2KvahMttUjmFZPy+JOYJ+jlNOF71K7oocc7rTP5E3caXmG389r/sbiXXnrppZdeeuml
l1566aWXXnrppZefQv4DtBu7mgBQAAA=
--------------040100090405040909000703--
