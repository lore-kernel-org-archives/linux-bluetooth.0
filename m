Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: "Stotland, Inga" <inga.stotland@intel.com>
To: "sbrown@cortland.com" <sbrown@cortland.com>,
        "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
CC: "johan.hedberg@gmail.com" <johan.hedberg@gmail.com>
Subject: Re: [PATCH BlueZ]mesh: meshctl add Node Identity option to connect
 command
Date: Mon, 4 Dec 2017 19:20:21 +0000
Message-ID: <1512415219.8154.5.camel@intel.com>
References: <1512404933.29399.10.camel@ewol.com>
In-Reply-To: <1512404933.29399.10.camel@ewol.com>
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-apXjFhU7J9uRE9fF0aF3"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

--=-apXjFhU7J9uRE9fF0aF3
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Steve,

On Mon, 2017-12-04 at 09:28 -0700, Steve Brown wrote:
> This adds the option to connect via either Node Identity or Network
> ID
> advertisements. Adding the node unicast address selects Node
> Identity.
>=20
> See Mesh Profile Specification 7.2.2.2 for further details.
>=20
> ---
>=20
> diff --git a/mesh/main.c b/mesh/main.c
> index d7e45e56b..e19b7f413 100644
> --- a/mesh/main.c
> +++ b/mesh/main.c
> @@ -1773,6 +1774,8 @@ static void cmd_connect(const char *arg)
>  			rl_printf("Invalid network index %s\n",
> arg);
>  			return;
>  		}
> +
> +		connection.unicast =3D strtol(end, NULL, 16);
>  	}
> =20
>  	if (discovering)
> @@ -1782,11 +1785,17 @@ static void cmd_connect(const char *arg)
>  	set_scan_filter_uuids(MESH_PROXY_SVC_UUID);
>  	discover_mesh =3D true;
> =20
> -	connection.type =3D CONN_TYPE_NETWORK;
> -
> +	if (connection.unicast =3D=3D UNASSIGNED_ADDRESS) {
> +		connection.type =3D CONN_TYPE_NETWORK;
> +		rl_printf("Looking for mesh network with net index
> %4.4x\n",
> +				connection.net_idx);
> +	} else {
> +		connection.type =3D CONN_TYPE_IDENTITY;
> +		rl_printf("Looking for node id %4.4x"
> +				" on network with net index
> %4.4x\n",
> +				connection.unicast,
> connection.net_idx);
> +	}
> =20
> -	rl_printf("Looking for mesh network with net index %4.4x\n",
> -							connection.n
> et_idx);
> =20
>  	if (g_dbus_proxy_method_call(default_ctrl->proxy,
>  			"StartDiscovery", NULL,
> start_discovery_reply,
> @@ -2005,7 +2014,8 @@ static const struct menu_entry
> meshctl_cmd_table[] =3D {
>  	{ "security",     "[0(low)/1(medium)/2(high)]",
> cmd_security,
>  				"Display or change provision
> security level"},
>  	{ "info",         "[dev]",    cmd_info, "Device
> information"},
> -	{ "connect",      "[net_idx]",cmd_connect, "Connect to mesh
> network"},
> +	{ "connect",      "[net_idx] [dst]",cmd_connect,
> +				"Connect to mesh network or node on
> network"},
>  	{ "discover-unprovisioned", "<on/off>",
> cmd_scan_unprovisioned_devices,
>  					"Look for devices to
> provision" },
>  	{ "provision",    "<uuid>",   cmd_start_prov, "Initiate
> provisioning"},
> --
> To unsubscribe from this list: send the line "unsubscribe linux-
> bluetooth" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

This is a valid extension. The patch looks good.

Thanks,

Inga
--=-apXjFhU7J9uRE9fF0aF3
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

MIAGCSqGSIb3DQEHAqCAMIACAQExCzAJBgUrDgMCGgUAMIAGCSqGSIb3DQEHAQAAoIIKbTCCBOsw
ggPToAMCAQICEFLpAsoR6ESdlGU4L6MaMLswDQYJKoZIhvcNAQEFBQAwbzELMAkGA1UEBhMCU0Ux
FDASBgNVBAoTC0FkZFRydXN0IEFCMSYwJAYDVQQLEx1BZGRUcnVzdCBFeHRlcm5hbCBUVFAgTmV0
d29yazEiMCAGA1UEAxMZQWRkVHJ1c3QgRXh0ZXJuYWwgQ0EgUm9vdDAeFw0xMzAzMTkwMDAwMDBa
Fw0yMDA1MzAxMDQ4MzhaMHkxCzAJBgNVBAYTAlVTMQswCQYDVQQIEwJDQTEUMBIGA1UEBxMLU2Fu
dGEgQ2xhcmExGjAYBgNVBAoTEUludGVsIENvcnBvcmF0aW9uMSswKQYDVQQDEyJJbnRlbCBFeHRl
cm5hbCBCYXNpYyBJc3N1aW5nIENBIDRBMIIBIjANBgkqhkiG9w0BAQEFAAOCAQ8AMIIBCgKCAQEA
4LDMgJ3YSVX6A9sE+jjH3b+F3Xa86z3LLKu/6WvjIdvUbxnoz2qnvl9UKQI3sE1zURQxrfgvtP0b
Pgt1uDwAfLc6H5eqnyi+7FrPsTGCR4gwDmq1WkTQgNDNXUgb71e9/6sfq+WfCDpi8ScaglyLCRp7
ph/V60cbitBvnZFelKCDBh332S6KG3bAdnNGB/vk86bwDlY6omDs6/RsfNwzQVwo/M3oPrux6y6z
yIoRulfkVENbM0/9RrzQOlyK4W5Vk4EEsfW2jlCV4W83QKqRccAKIUxw2q/HoHVPbbETrrLmE6RR
Z/+eWlkGWl+mtx42HOgOmX0BRdTRo9vH7yeBowIDAQABo4IBdzCCAXMwHwYDVR0jBBgwFoAUrb2Y
ejS0Jvf6xCZU7wO94CTLVBowHQYDVR0OBBYEFB5pKrTcKP5HGE4hCz+8rBEv8Jj1MA4GA1UdDwEB
/wQEAwIBhjASBgNVHRMBAf8ECDAGAQH/AgEAMDYGA1UdJQQvMC0GCCsGAQUFBwMEBgorBgEEAYI3
CgMEBgorBgEEAYI3CgMMBgkrBgEEAYI3FQUwFwYDVR0gBBAwDjAMBgoqhkiG+E0BBQFpMEkGA1Ud
HwRCMEAwPqA8oDqGOGh0dHA6Ly9jcmwudHJ1c3QtcHJvdmlkZXIuY29tL0FkZFRydXN0RXh0ZXJu
YWxDQVJvb3QuY3JsMDoGCCsGAQUFBwEBBC4wLDAqBggrBgEFBQcwAYYeaHR0cDovL29jc3AudHJ1
c3QtcHJvdmlkZXIuY29tMDUGA1UdHgQuMCygKjALgQlpbnRlbC5jb20wG6AZBgorBgEEAYI3FAID
oAsMCWludGVsLmNvbTANBgkqhkiG9w0BAQUFAAOCAQEAKcLNo/2So1Jnoi8G7W5Q6FSPq1fmyKW3
sSDf1amvyHkjEgd25n7MKRHGEmRxxoziPKpcmbfXYU+J0g560nCo5gPF78Wd7ZmzcmCcm1UFFfIx
fw6QA19bRpTC8bMMaSSEl8y39Pgwa+HENmoPZsM63DdZ6ziDnPqcSbcfYs8qd/m5d22rpXq5IGVU
tX6LX7R/hSSw/3sfATnBLgiJtilVyY7OGGmYKCAS2I04itvSS1WtecXTt9OZDyNbl7LtObBrgMLh
ZkpJW+pOR9f3h5VG2S5uKkA7Th9NC9EoScdwQCAIw+UWKbSQ0Isj2UFL7fHKvmqWKVTL98sRzvI3
seNC4DCCBXowggRioAMCAQICEzMAAKB78iXkGFQW8ngAAAAAoHswDQYJKoZIhvcNAQEFBQAweTEL
MAkGA1UEBhMCVVMxCzAJBgNVBAgTAkNBMRQwEgYDVQQHEwtTYW50YSBDbGFyYTEaMBgGA1UEChMR
SW50ZWwgQ29ycG9yYXRpb24xKzApBgNVBAMTIkludGVsIEV4dGVybmFsIEJhc2ljIElzc3Vpbmcg
Q0EgNEEwHhcNMTcwNjA1MTg0MTMyWhcNMTgwNTMxMTg0MTMyWjBBMRcwFQYDVQQDEw5TdG90bGFu
ZCwgSW5nYTEmMCQGCSqGSIb3DQEJARYXaW5nYS5zdG90bGFuZEBpbnRlbC5jb20wggEiMA0GCSqG
SIb3DQEBAQUAA4IBDwAwggEKAoIBAQDjwJcVTvNXWA8pOj082ng7cqITqUwipPdiCjr0wYkgRImw
tUX2e3F4HG1oLeoDoNj5AzPPiCghxzLF5ezZAquV9ooNCVux13qtWgQhXjR9plaHdn6zhfRLcG7o
wDuyPjOWqAdAqzkJKhDYQ04GqNOJi4b7HeDMnD7moWlf+07FWMKl9LbhUhcTazKjnQz2qLbXkugE
hg3clmjFZcqfMne009UirbRv5TFe/mvvgG0DComDpAy9dv/d9PHqBIZOZ58MsrRop8oBdKx2khnI
s+FjFlMZRl+6tAsU6MKgNPjqLZM/5/UApupmE4I4+I7tJzH7J+/PQP756UTWANxeOFXXAgMBAAGj
ggIxMIICLTAdBgNVHQ4EFgQUGgH+hmVcYfkjP42Io/H7dyFj/xEwHwYDVR0jBBgwFoAUHmkqtNwo
/kcYTiELP7ysES/wmPUwZQYDVR0fBF4wXDBaoFigVoZUaHR0cDovL3d3dy5pbnRlbC5jb20vcmVw
b3NpdG9yeS9DUkwvSW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIwSXNzdWluZyUyMENBJTIwNEEu
Y3JsMIGfBggrBgEFBQcBAQSBkjCBjzBpBggrBgEFBQcwAoZdaHR0cDovL3d3dy5pbnRlbC5jb20v
cmVwb3NpdG9yeS9jZXJ0aWZpY2F0ZXMvSW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIwSXNzdWlu
ZyUyMENBJTIwNEEuY3J0MCIGCCsGAQUFBzABhhZodHRwOi8vb2NzcC5pbnRlbC5jb20vMAsGA1Ud
DwQEAwIHgDA8BgkrBgEEAYI3FQcELzAtBiUrBgEEAYI3FQiGw4x1hJnlUYP9gSiFjp9TgpHACWeB
3r05lfBDAgFkAgEJMB8GA1UdJQQYMBYGCCsGAQUFBwMEBgorBgEEAYI3CgMMMCkGCSsGAQQBgjcV
CgQcMBowCgYIKwYBBQUHAwQwDAYKKwYBBAGCNwoDDDBLBgNVHREERDBCoCcGCisGAQQBgjcUAgOg
GQwXaW5nYS5zdG90bGFuZEBpbnRlbC5jb22BF2luZ2Euc3RvdGxhbmRAaW50ZWwuY29tMA0GCSqG
SIb3DQEBBQUAA4IBAQBL46xSWeaTcedNEVjOvWuiMQNz8rRju5xKMBBA6PlBi7C3pe2oPLrn5fuy
93vXsrFtVyxQs+rp19FwjthhpLl743f7SLWA8AGL+Mm2Uq8WSwhpgUBWjbqSZuyEZUvrLNMLIMch
eNbju3KeUiY/cMt6ovGcAGrZG1KMRpL8DC9i/dwDMGFXmIiOrMTqZFSj3i+Fn05WVkRRRUmxoKWi
KQpGTgKtfHEfKcns+tJssBGYoop4jdF1voX59gnxpIjIO97LpTd5mYWjSufKLAXZ4E3JBwLs2nYA
hPjGOjiW4KniOu8alYzWYdXUNG7HCHZq+V/EKgLxNYrhwDF1meav+rMRMYICFzCCAhMCAQEwgZAw
eTELMAkGA1UEBhMCVVMxCzAJBgNVBAgTAkNBMRQwEgYDVQQHEwtTYW50YSBDbGFyYTEaMBgGA1UE
ChMRSW50ZWwgQ29ycG9yYXRpb24xKzApBgNVBAMTIkludGVsIEV4dGVybmFsIEJhc2ljIElzc3Vp
bmcgQ0EgNEECEzMAAKB78iXkGFQW8ngAAAAAoHswCQYFKw4DAhoFAKBdMBgGCSqGSIb3DQEJAzEL
BgkqhkiG9w0BBwEwHAYJKoZIhvcNAQkFMQ8XDTE3MTIwNDE5MjAxOVowIwYJKoZIhvcNAQkEMRYE
FC7s7Txo3YKJpSHxE5uX3evbdcQmMA0GCSqGSIb3DQEBAQUABIIBAETREq6zmB0aEZHHalTwVy4m
1N53dFiIcLhQ+KRHpDxmQAXgdUkowrQd6X5DCzF5DMZ3VDiBNsuUmuqlANwFNm4NOUKmaYLFfcKf
ReAkZ56+sV1L06nKtUOKxaBJjYPqIwo1kZQpk+RAZAmv5HD5IYQOfOxMNli1MPr7qtR58xtV7rRG
uK0XYmktSI7vnCTR5hH8Vdlo5MKLqwsbCv8Ge5JiiPfyeJkkG0d8pg5EPiRlh5CU8OeWsAWF5E0L
Ia+/ijjs75PUvVlwSUf7xFWcYwLAtb2iwHjbw6eC7ejgK7UDSM1/13hKBzH5HilJeGW7I4mqwz5d
xl+/WC4VmqIdOjkAAAAAAAA=


--=-apXjFhU7J9uRE9fF0aF3--
