Return-Path: <cyrus@holtmann.org>
Message-ID: <4DC5786E.5060009@podzimek.org>
Date: Sat, 07 May 2011 18:50:54 +0200
From: Andrej Podzimek <andrej@podzimek.org>
Mime-Version: 1.0
Content-Type: multipart/signed; protocol="application/pkcs7-signature"; micalg=sha1; boundary="=_charon-7959-1304787071-0001-2"
To: linux-bluetooth@vger.kernel.org, stable@kernel.org, greg@kroah.com
Subject: Re: btusb not working in 2.6.38.4
References: <4DB8A51A.8080608@podzimek.org> <20110428051124.GC2214@joana>
In-Reply-To: <20110428051124.GC2214@joana>
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_charon-7959-1304787071-0001-2
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: quoted-printable

> Hi Andrej,
>
> * Andrej Podzimek<andrej@podzimek.org>  [2011-04-28 01:22:02 +0200]:
>
>> Hello,
>>
>> after a recent kernel update on Arch Linux (2.6.38.4), I can see the f=
ollowing problem in dmesg:
>>
>> ------------[ cut here ]------------
>> WARNING: at lib/kobject.c:595 kobject_put+0x40/0x50()
>> Hardware name: To Be Filled By O.E.M.
>> kobject: '(null)' (ffff88023f60d5a0): is not initialized, yet kobject_=
put() is being called.
>> Modules linked in: btusb(+) bluetooth rfkill usbhid hid button i2c_i80=
1 i2c_core r8169 mii iTCO_wdt iTCO_vendor_support psmouse sg serio_raw ev=
dev pcspkr ip_tables ip6_tables x_tables tpm_tis tpm tpm_bios w83627ehf h=
wmon_vid coretemp ext4 mbcache jbd2 crc16 dm_mod usb_storage raid456 asyn=
c_raid6_recov async_pq raid6_pq async_xor xor async_memcpy async_tx md_mo=
d uhci_hcd xhci_hcd ehci_hcd usbcore sd_mod crc_t10dif ahci libahci libat=
a scsi_mod cpufreq_ondemand acpi_cpufreq freq_table processor mperf i7cor=
e_edac edac_core
>> Pid: 1820, comm: modprobe Not tainted 2.6.38-ARCH #1
>> Call Trace:
>>    [<ffffffff8103a86b>] ? warn_slowpath_common+0x7b/0xc0
>>    [<ffffffff8103a965>] ? warn_slowpath_fmt+0x45/0x50
>>    [<ffffffff81248d3f>] ? skb_dequeue+0x5f/0x80
>>    [<ffffffff8116b6f0>] ? kobject_put+0x40/0x50
>>    [<ffffffffa025f85c>] ? btusb_probe+0x57c/0x5e0 [btusb]
>>    [<ffffffffa00b85d5>] ? usb_probe_interface+0xe5/0x1e0 [usbcore]
>>    [<ffffffff81215aaf>] ? driver_probe_device+0x6f/0x190
>>    [<ffffffff81215c63>] ? __driver_attach+0x93/0xa0
>>    [<ffffffff81215bd0>] ? __driver_attach+0x0/0xa0
>>    [<ffffffff81214b23>] ? bus_for_each_dev+0x53/0x80
>>    [<ffffffff812153f8>] ? bus_add_driver+0x188/0x260
>>    [<ffffffff81215e3a>] ? driver_register+0x6a/0x130
>>    [<ffffffffa00b748a>] ? usb_register_driver+0x8a/0x180 [usbcore]
>>    [<ffffffffa011c000>] ? btusb_init+0x0/0x1000 [btusb]
>>    [<ffffffff810001dc>] ? do_one_initcall+0x3c/0x170
>>    [<ffffffff8106db3a>] ? sys_init_module+0xda/0x230
>>    [<ffffffff8100243b>] ? system_call_fastpath+0x16/0x1b
>> ---[ end trace 9c4648061ddb0b67 ]---
>>
>> Presumably, Bluetooth does not seem to work at all (i.e., hciconfig -a=
 does not output anything).
>>
>> The output from lsusb -v relevant to the specific device is attached.
>>
>> The device worked 100% flawlessly with 2.6.38.3. I had an a2dp headset=
 and a mouse paired with it, both of which worked perfectly fine in paral=
lel.
>
> The only Bluetooth change in 2.6.38.4 is: https://lkml.org/lkml/2011/4/=
19/406
> However I don't think this patch is causing this issue. Do you care to =
patch -R it
> and test?
> If the problem is somewhere else we have to go with a bisect, there are=
 only
> 70 patches, so it shouldn't take to long.
>
> Greg, any idea on that? Are there similar reports of warnings for 2.6.3=
8.4?

Hello,

I'm sorry for this false positive. It was just a typical PEBKAC. The mach=
ine runs a WiFi access point and requires ath9k from compat-wireless (sin=
ce the mainline ath9k can do no better than 2 Mb/s in AP mode). I install=
ed compat-wireless as usual, but forgot to run scripts/driver-select. Con=
sequently, all drivers (including Bluetooth, namely btusb) got replaced. =
So the backtrace was caused by using btusb from compat-wireless (April 26=
 2011) with kernel 2.6.38.4. The problem does *not* occur in a standard v=
anilla kernel.

Andrej


--=_charon-7959-1304787071-0001-2
Content-Type: application/pkcs7-signature; name="smime.p7s"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="smime.p7s"
Content-Description: S/MIME Cryptographic Signature

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIISszCC
BakwggSRoAMCAQICAT0wDQYJKoZIhvcNAQEFBQAwgYQxFDASBgNVBAMMC1BvZHppbWVrIENB
MQswCQYDVQQGEwJDWjEOMAwGA1UEBwwFWmzDrW4xFTATBgNVBAoMDHBvZHppbWVrLm9yZzEV
MBMGA1UECwwMcG9kemltZWsub3JnMSEwHwYJKoZIhvcNAQkBFhJhZG1pbkBwb2R6aW1lay5v
cmcwHhcNMTEwMzMwMTYwNzM3WhcNMTIwMzI5MTYwNzM3WjCBiTELMAkGA1UEBhMCQ1oxDjAM
BgNVBAcMBVpsw61uMRUwEwYDVQQKDAxwb2R6aW1lay5vcmcxFTATBgNVBAsMDHBvZHppbWVr
Lm9yZzEYMBYGA1UEAwwPQW5kcmVqIFBvZHppbWVrMSIwIAYJKoZIhvcNAQkBFhNhbmRyZWpA
cG9kemltZWsub3JnMIICIjANBgkqhkiG9w0BAQEFAAOCAg8AMIICCgKCAgEAqxdSN8GoC0Ny
yPVoc9uZhuN+ezgtvKodMPunwlZCqaV4p7g3rgzDe3rrQ+Afkj05R+7WqLStjPn1lr9KINtn
mxqjUF07U4CqGZgKCruKxWiTI1pvpTljTKssoa/sbEf0UgjQvO0UNhjYF1iHE1VBVWALKgI0
Kbb+zCftvdwtnKVh9ncQushra5MZLEeMTcXisyzasFgDb8teLn8MtDQuJb0QzHkqhwRBzj7u
pKTGKcZxGhxzZdmcqfvZdjLAcxQApLyMq7O8Y+0FHgZHW5peeuHSgeC+kScffJvGloHGPzVt
CqODxDOHtjS8ZfkAKKt7PKdTfqiF8/+/zZ8pT98GlLXZtrz5IXlt8YQRh3ugE+o76vikx6ho
SZQZsVFsc0KT/S7PA5fwkorUyhhuYcs53rTDO2IN4kPVoU2Tq6iyV6D8zF5/OiMxJ5lhYUGu
RjAHM4hAFJ1ROp3LRn5VwYotogdj81xucd/hW7tc1HUN7lHnd51WK4xXjJ5o1gF0wUUYlxMc
wpXqv9ZW1P+zD28Wj7BxmiAtll5oAButMBjLVWgJYlpOY3Ikh6rx+TVAwfDD5oVmOzc8NAYI
pJCSmrX4MDahymq+ayjOhIw2OPXaFBbGP7YTgp68e86p+I2JTQ/tXCH08MZYFpRB11M3dI2L
IkDlcWOm4Ptc3794p8yS0T8CAwEAAaOCAR0wggEZMAkGA1UdEwQCMAAwHQYDVR0OBBYEFBas
PXfIN+SpJaWzrihb8DnOUJGZMIG5BgNVHSMEgbEwga6AFE6juEwI0K5X6Rv/eMJTk7Q8cg65
oYGKpIGHMIGEMRQwEgYDVQQDDAtQb2R6aW1layBDQTELMAkGA1UEBhMCQ1oxDjAMBgNVBAcM
BVpsw61uMRUwEwYDVQQKDAxwb2R6aW1lay5vcmcxFTATBgNVBAsMDHBvZHppbWVrLm9yZzEh
MB8GCSqGSIb3DQEJARYSYWRtaW5AcG9kemltZWsub3JnggkAkctHSQfLqowwMQYJYIZIAYb4
QgEEBCQWImh0dHBzOi8vY2EucG9kemltZWsub3JnL2NhLWNybC5wZW0wDQYJKoZIhvcNAQEF
BQADggEBAH5XwT/0jYayTafRvAcJfRAm5E6z6wqX0x5OYNdO6JQ9JcCYQeFa1XD80Yu/VHy8
NmaF+p2iAaCZWcTbIeAzidSozgbDJlVYcMdUjer0WHbBpyIBcVJZY4im/ygyVTACOIlLnfXM
ZaNfdsCBP/minHHonm5e8DU8Go2/viAKPfXxsCOzl0bZFnU2b2D5Ii6Gk4n6kyduzQWYVUqA
fNQjQIKZDSIMPzh119QsbR+6vNQ5t46qpHVMUkn1JLf+MIJQSBjxoXXt9ORnpTRstVw1ATPz
RxDYYltHxaqKUY07bSo5czyWyUN5Rd35SP1mlQSHJhmNVUuOHQ58yDEADUEqkSkwggY0MIIE
HKADAgECAgEgMA0GCSqGSIb3DQEBBQUAMH0xCzAJBgNVBAYTAklMMRYwFAYDVQQKEw1TdGFy
dENvbSBMdGQuMSswKQYDVQQLEyJTZWN1cmUgRGlnaXRhbCBDZXJ0aWZpY2F0ZSBTaWduaW5n
MSkwJwYDVQQDEyBTdGFydENvbSBDZXJ0aWZpY2F0aW9uIEF1dGhvcml0eTAeFw0wNzEwMjQy
MTAyNTVaFw0xNzEwMjQyMTAyNTVaMIGMMQswCQYDVQQGEwJJTDEWMBQGA1UEChMNU3RhcnRD
b20gTHRkLjErMCkGA1UECxMiU2VjdXJlIERpZ2l0YWwgQ2VydGlmaWNhdGUgU2lnbmluZzE4
MDYGA1UEAxMvU3RhcnRDb20gQ2xhc3MgMiBQcmltYXJ5IEludGVybWVkaWF0ZSBDbGllbnQg
Q0EwggEiMA0GCSqGSIb3DQEBAQUAA4IBDwAwggEKAoIBAQDLKIVFnAEs+xnyq6UzjCqgDcvQ
Ve1dIoFnRsQPCFO+y92k8RK0Pn3MbQ2Gd+mehh9GBZ+36uUQA7Xj9AGM6wgPhEE34vKtfpAN
5tJ8LcFxveDObCKrL7O5UT9WsnAZHv7OYPYSR68mdmnEnJ83M4wQgKO19b+Rt8sPDAz9ptkQ
sntCn4GeJzg3q2SVc4QJTg/WHo7wF2ah5LMOeh8xJVSKGEmd6uPkSbj113yKMm8vmNptRPmM
1+YgmVwcdOYJOjCgFtb2sOP79jji8uhWR91xx7TpM1K3hv/wrBZwffrmmEpUeuXHRs07JqCC
vFh9coKF4UQZvfEg+x3/69xRCzb1AgMBAAGjggGtMIIBqTAPBgNVHRMBAf8EBTADAQH/MA4G
A1UdDwEB/wQEAwIBBjAdBgNVHQ4EFgQUrlWDb+wxyrn3HfqvazHzyB3jrLswHwYDVR0jBBgw
FoAUTgvvGqRAW6UXaYcwyjRoQ9BBrvIwZgYIKwYBBQUHAQEEWjBYMCcGCCsGAQUFBzABhhto
dHRwOi8vb2NzcC5zdGFydHNzbC5jb20vY2EwLQYIKwYBBQUHMAKGIWh0dHA6Ly93d3cuc3Rh
cnRzc2wuY29tL3Nmc2NhLmNydDBbBgNVHR8EVDBSMCegJaAjhiFodHRwOi8vd3d3LnN0YXJ0
c3NsLmNvbS9zZnNjYS5jcmwwJ6AloCOGIWh0dHA6Ly9jcmwuc3RhcnRzc2wuY29tL3Nmc2Nh
LmNybDCBgAYDVR0gBHkwdzB1BgsrBgEEAYG1NwECATBmMC4GCCsGAQUFBwIBFiJodHRwOi8v
d3d3LnN0YXJ0c3NsLmNvbS9wb2xpY3kucGRmMDQGCCsGAQUFBwIBFihodHRwOi8vd3d3LnN0
YXJ0c3NsLmNvbS9pbnRlcm1lZGlhdGUucGRmMA0GCSqGSIb3DQEBBQUAA4ICAQA6qScNyNO0
FpHvaZTQacVMXH33O51KyEKSRw3IvdQxRu31YR0ZDGdSfgSoOVDVMSBSdmfQfdDInHPzV3LO
5DwUXZ+lxjv7z3PO2OkfnFkvTXPfn6dxJ5rJveDsTsCPcJ/Kp6/+qN5g+J6D/SaYcFD018B6
L42r0Z4VEBy36P4tjRtF14Ex10tl5tJFVKM16qWKQHbpjIgf73s49UB0CQ5lHT2DHKfq3oPf
dNc5Mk93w1v4ryVb+qVrZIej8NsrWU+5r4O2IV91edDb/OtHFddZqHFFXKgS79IHE/hwQ2LW
7r3sTX7cDUCg+dfdwO8zeLxuwk2JF8crUoyrl66RGrRIhT8VoG/OJ1Y9uUlOav69V4cG8upi
4ZG2l7JZFbcBFk91Wp+Payo5SuF61CmGFrZ386umkmpObtFacXda2O/bVoQ9xHQrzoTc/0KZ
TWvlZCLK3Ke/vGYT9ZdW9lOjGsSFbXrlTA919L84iMK+48WGnvRWY28ZaVHpql43AtEGhXze
6iNCbEDACy+4hkQYOytAqDgcxAnQ937mYpeZFPyz/XK9QSt9VNFMuudWxZwDDDJKoQAoSG59
Hou9lZ26UrK60nRdAQBmEPL8h2nuWgoPh++XVQld9yuhbsWa39Pck8/lcfz5HUVGJF5mc/zk
38iV7FDlF68puiryNq2KXHEpOTCCBsowggWyoAMCAQICAgtGMA0GCSqGSIb3DQEBBQUAMIGM
MQswCQYDVQQGEwJJTDEWMBQGA1UEChMNU3RhcnRDb20gTHRkLjErMCkGA1UECxMiU2VjdXJl
IERpZ2l0YWwgQ2VydGlmaWNhdGUgU2lnbmluZzE4MDYGA1UEAxMvU3RhcnRDb20gQ2xhc3Mg
MiBQcmltYXJ5IEludGVybWVkaWF0ZSBDbGllbnQgQ0EwHhcNMTAwOTI3MDA0ODU2WhcNMTIw
OTI3MDk1NjI4WjCBwjEgMB4GA1UEDRMXMjY0MzU2LVV6cDI4MnFISHRiQ2I1ZDMxCzAJBgNV
BAYTAkNaMRUwEwYDVQQIEwxabGluc2t5IEtyYWoxDTALBgNVBAcTBFpsaW4xLTArBgNVBAsT
JFN0YXJ0Q29tIFZlcmlmaWVkIENlcnRpZmljYXRlIE1lbWJlcjEYMBYGA1UEAxMPQW5kcmVq
IFBvZHppbWVrMSIwIAYJKoZIhvcNAQkBFhNhbmRyZWpAcG9kemltZWsub3JnMIIBIjANBgkq
hkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEArldROEvlaSy4OX9PPg22Xl7GCivziuBcbrkH+St9
vIAyefDb3kfdtHT/J1NRlQDYTrDFQ3cZM2J7vicm4/uu67KzdAF/14mdml1b1prWRiUT3IRw
Cwbt8wuNhZfa6dGkQ374EuOWDVX+5YCEufr5GMHrkkZy5RYtO9r3avglOI1ZB2F9Z56Zb42k
S7N2ebEE7Oj+pFeQwaj2pz/B4d3gu6wX+c7GwDiy26iN/33Cl+spa5uFWITb8XD6P6aob9Ep
yDxn90KEr5+9ug1tmh833Kdll4mmjzAv5ZK0iVFnxsBq+V1TN/2NW6oiIvOLxTIHCfC1MdYi
88HMC1PaQZF4ywIDAQABo4IC/DCCAvgwCQYDVR0TBAIwADALBgNVHQ8EBAMCBLAwHQYDVR0l
BBYwFAYIKwYBBQUHAwIGCCsGAQUFBwMEMB0GA1UdDgQWBBT3GSEvnmmKZPBGzpElp7HtmoV7
FzAfBgNVHSMEGDAWgBSuVYNv7DHKufcd+q9rMfPIHeOsuzAeBgNVHREEFzAVgRNhbmRyZWpA
cG9kemltZWsub3JnMIIBQgYDVR0gBIIBOTCCATUwggExBgsrBgEEAYG1NwECAjCCASAwLgYI
KwYBBQUHAgEWImh0dHA6Ly93d3cuc3RhcnRzc2wuY29tL3BvbGljeS5wZGYwNAYIKwYBBQUH
AgEWKGh0dHA6Ly93d3cuc3RhcnRzc2wuY29tL2ludGVybWVkaWF0ZS5wZGYwgbcGCCsGAQUF
BwICMIGqMBQWDVN0YXJ0Q29tIEx0ZC4wAwIBARqBkUxpbWl0ZWQgTGlhYmlsaXR5LCBzZWUg
c2VjdGlvbiAqTGVnYWwgTGltaXRhdGlvbnMqIG9mIHRoZSBTdGFydENvbSBDZXJ0aWZpY2F0
aW9uIEF1dGhvcml0eSBQb2xpY3kgYXZhaWxhYmxlIGF0IGh0dHA6Ly93d3cuc3RhcnRzc2wu
Y29tL3BvbGljeS5wZGYwYwYDVR0fBFwwWjAroCmgJ4YlaHR0cDovL3d3dy5zdGFydHNzbC5j
b20vY3J0dTItY3JsLmNybDAroCmgJ4YlaHR0cDovL2NybC5zdGFydHNzbC5jb20vY3J0dTIt
Y3JsLmNybDCBjgYIKwYBBQUHAQEEgYEwfzA5BggrBgEFBQcwAYYtaHR0cDovL29jc3Auc3Rh
cnRzc2wuY29tL3N1Yi9jbGFzczIvY2xpZW50L2NhMEIGCCsGAQUFBzAChjZodHRwOi8vd3d3
LnN0YXJ0c3NsLmNvbS9jZXJ0cy9zdWIuY2xhc3MyLmNsaWVudC5jYS5jcnQwIwYDVR0SBBww
GoYYaHR0cDovL3d3dy5zdGFydHNzbC5jb20vMA0GCSqGSIb3DQEBBQUAA4IBAQCEI21EOM71
hKXRNFHbWFaemV86fxAs1yMl6SohZhNRea/Pc5hMpoFoUZBf0qJ3AvFy2PzsyspTsqZhBOwo
I3rVJlgZapKi4x4k7FXM43xFmU/koQLdQPDS1Jfbr8zFTVBx+K6xD+L9y+M1M7JX+EcQgTIu
CZn80YjSxEpAGND09NUPrgwJ/v9Nn5zqbEraf5MRSAun11fhkqIORlqkAi393N+kvXEsAtRJ
A0CizQzFfmLFNY4xWtWtRYJGatOIzDO8s8gA8kfC99CcygpRQbrMBaBZ3fzMgoNXhP7A6801
XYg+flS0kxPSubBbEfEUCVOHNcm4TAdyKwYehI9N8PD+MYIDuzCCA7cCAQEwgZMwgYwxCzAJ
BgNVBAYTAklMMRYwFAYDVQQKEw1TdGFydENvbSBMdGQuMSswKQYDVQQLEyJTZWN1cmUgRGln
aXRhbCBDZXJ0aWZpY2F0ZSBTaWduaW5nMTgwNgYDVQQDEy9TdGFydENvbSBDbGFzcyAyIFBy
aW1hcnkgSW50ZXJtZWRpYXRlIENsaWVudCBDQQICC0YwCQYFKw4DAhoFAKCCAfwwGAYJKoZI
hvcNAQkDMQsGCSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTEwNTA3MTY1MDU0WjAjBgkq
hkiG9w0BCQQxFgQUoKO0XJ7o//t+z5WoG96HWu+PtaUwXwYJKoZIhvcNAQkPMVIwUDALBglg
hkgBZQMEAQIwCgYIKoZIhvcNAwcwDgYIKoZIhvcNAwICAgCAMA0GCCqGSIb3DQMCAgFAMAcG
BSsOAwIHMA0GCCqGSIb3DQMCAgEoMIGbBgkrBgEEAYI3EAQxgY0wgYowgYQxFDASBgNVBAMM
C1BvZHppbWVrIENBMQswCQYDVQQGEwJDWjEOMAwGA1UEBwwFWmzDrW4xFTATBgNVBAoMDHBv
ZHppbWVrLm9yZzEVMBMGA1UECwwMcG9kemltZWsub3JnMSEwHwYJKoZIhvcNAQkBFhJhZG1p
bkBwb2R6aW1lay5vcmcCAT0wgZ0GCyqGSIb3DQEJEAILMYGNoIGKMIGEMRQwEgYDVQQDDAtQ
b2R6aW1layBDQTELMAkGA1UEBhMCQ1oxDjAMBgNVBAcMBVpsw61uMRUwEwYDVQQKDAxwb2R6
aW1lay5vcmcxFTATBgNVBAsMDHBvZHppbWVrLm9yZzEhMB8GCSqGSIb3DQEJARYSYWRtaW5A
cG9kemltZWsub3JnAgE9MA0GCSqGSIb3DQEBAQUABIIBAC+6wfed7n6E+sVJcD0msqdvm7hb
x3AD4LZpCdFXINrNZBnQgfCENwGXKbnh2I+htT6bt8wipr2DjaKceLXHFJb8lm+Dez2LW7PH
opUbDZyzYVXMRwC5lFHHl4jU3/xApmK4wtJKnt4hUKcyvHq1o1sDJMFOXcsgteGhZ33E3XXf
qrb7kLsUaf5UM2YcQYNPYUHI3B0zdncovCgq8eSUdH7NcMljIui4GlbZzdtctLTM6XXA4mny
YV+1MP9GvfvZNA0xUbK2mEKDBG5eZMZdBJajkDhdK9qEWpzx79D+jqbV6hp+im2QofX6YyDV
tb7D3hZ0DdT0b6lcaU8lxePB3JAAAAAAAAA=
--=_charon-7959-1304787071-0001-2--
