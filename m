Return-Path: <SRS0=asem=TU=vger.kernel.org=linux-bluetooth-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 780AFC04AAF
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 May 2019 04:15:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 46908206BA
	for <linux-bluetooth@archiver.kernel.org>; Mon, 20 May 2019 04:15:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726053AbfETEPP (ORCPT
        <rfc822;linux-bluetooth@archiver.kernel.org>);
        Mon, 20 May 2019 00:15:15 -0400
Received: from mga04.intel.com ([192.55.52.120]:47478 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725372AbfETEPP (ORCPT <rfc822;linux-bluetooth@vger.kernel.org>);
        Mon, 20 May 2019 00:15:15 -0400
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 May 2019 21:15:14 -0700
X-ExtLoop1: 1
Received: from orsmsx103.amr.corp.intel.com ([10.22.225.130])
  by fmsmga001.fm.intel.com with ESMTP; 19 May 2019 21:15:14 -0700
Received: from orsmsx114.amr.corp.intel.com (10.22.240.10) by
 ORSMSX103.amr.corp.intel.com (10.22.225.130) with Microsoft SMTP Server (TLS)
 id 14.3.408.0; Sun, 19 May 2019 21:15:14 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.182]) by
 ORSMSX114.amr.corp.intel.com ([169.254.8.116]) with mapi id 14.03.0415.000;
 Sun, 19 May 2019 21:15:13 -0700
From:   "Stotland, Inga" <inga.stotland@intel.com>
To:     "daniele.biagetti@cblelectronics.com" 
        <daniele.biagetti@cblelectronics.com>
CC:     "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Subject: Re: [PATCH 1/4] meshctl: Subscription Delete message added to
 configuration client
Thread-Topic: [PATCH 1/4] meshctl: Subscription Delete message added to
 configuration client
Thread-Index: AdUL66zO9sHo+9FiTgiUDqkruHD+iwDEZ3kA
Date:   Mon, 20 May 2019 04:15:13 +0000
Message-ID: <12921b4b0de3636196735121c66296cb3b130170.camel@intel.com>
References: <000601d50bf4$b0527f60$10f77e20$@cblelectronics.com>
In-Reply-To: <000601d50bf4$b0527f60$10f77e20$@cblelectronics.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: yes
X-MS-TNEF-Correlator: 
x-originating-ip: [10.254.176.192]
Content-Type: multipart/signed; micalg=sha-1;
        protocol="application/x-pkcs7-signature"; boundary="=-xCGanzV4VvXTToCl6kLK"
MIME-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-bluetooth.vger.kernel.org>
X-Mailing-List: linux-bluetooth@vger.kernel.org

--=-xCGanzV4VvXTToCl6kLK
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi Daniele,

On Thu, 2019-05-16 at 16:35 +0200, Daniele Biagetti wrote:
> Subscription delete command/message added to the=20
> configuration client model.
>=20
> Signed-off-by: Daniele Biagetti <daniele.biagetti@cblelectronics.com>

The submitted patches should not contain "Signed-off-by"

>=20
> ---
>  tools/mesh/config-client.c | 40
> ++++++++++++++++++++++++++++++++++++++
>  1 file changed, 40 insertions(+)
>=20
> diff --git a/tools/mesh/config-client.c b/tools/mesh/config-client.c
> index df2643622..bff38e7a3 100644
> --- a/tools/mesh/config-client.c
> +++ b/tools/mesh/config-client.c
> @@ -1042,6 +1042,44 @@ static void cmd_sub_get(int argc, char
> *argv[])
>  	return bt_shell_noninteractive_quit(EXIT_SUCCESS);
>  }
> =20
> +static void cmd_sub_del(int argc, char *argv[])
> +{
> +        uint16_t n;
> +        uint8_t msg[32];
> +        int parm_cnt;
> +
> +        if (IS_UNASSIGNED(target)) {
> +                bt_shell_printf("Destination not set\n");
> +                return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +        }
> +
> +        n =3D mesh_opcode_set(OP_CONFIG_MODEL_SUB_DELETE, msg);
> +
> +        parm_cnt =3D read_input_parameters(argc, argv);
> +        if (parm_cnt !=3D 3) {
> +                bt_shell_printf("Bad arguments: %s\n", argv[1]);
> +                return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +        }
> +
> +        /* Per Mesh Profile 4.3.2.19 */
> +        /* Element Address */
> +        put_le16(parms[0], msg + n);
> +        n +=3D 2;
> +        /* Subscription Address */
> +        put_le16(parms[1], msg + n);
> +        n +=3D 2;
> +        /* SIG Model ID */
> +        put_le16(parms[2], msg + n);
> +        n +=3D 2;
> +
> +        if (!config_send(msg, n)) {
> +                bt_shell_printf("Failed to send \"ADD
> SUBSCRIPTION\"\n");
> +                return bt_shell_noninteractive_quit(EXIT_FAILURE);
> +        }
> +
> +        return bt_shell_noninteractive_quit(EXIT_SUCCESS);
> +}
> +
>  static void cmd_mod_appidx_get(int argc, char *argv[])
>  {
>  	uint16_t n;
> @@ -1237,6 +1275,8 @@ static const struct bt_shell_menu cfg_menu =3D {
>  				cmd_sub_add,    "Add subscription"},
>  	{"sub-get", "<ele_addr> <model id>",
>  				cmd_sub_get,    "Get subscription"},
> +	{"sub-del", "<ele_addr> <sub_addr> <model id>",
> +				cmd_sub_del,    "Delete subscription"},
>  	{"node-reset",		NULL,                    cmd_node_res
> et,
>  				"Reset a node and remove it from
> network"},
>  	{} },

Could you please re-format your patches so they do not contain DOS
style  end-of-line (^M)?

Please make sure that you follow the guidelines from
bluez/doc/coding-style.txt

Also, a general comment about commit message style: it is strongly
preferred that the commit subject line statement is in imprerative
mood, see good description here:=20
https://gist.github.com/robertpainsi/b632364184e70900af4ab688decf6f53

Ome more thing. In general, when submitting a patch set, i.e., more
than one patch, it's a good practice to precede the set with a cover
letter (i.e., use --cover-letter option with your "git format-patch"
command) that describes what is the purpose of this patch set. When
submitting a single patch, a descriptive commit message is normally
sufficient enough.

Best regards,

Inga

--=-xCGanzV4VvXTToCl6kLK
Content-Type: application/x-pkcs7-signature; name="smime.p7s"
Content-Disposition: attachment; filename="smime.p7s"
Content-Transfer-Encoding: base64

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
k3sf6w6ZKbZbz2V54rncMEXM3N/P4C6ZHZR0XYqh5m1vWxZYYVzTuDEH1C8W+b3KzldrAgMBAAGj
ggIwMIICLDAdBgNVHQ4EFgQUcdzZH9M8OSxLujP+AToiD5oYMRkwHwYDVR0jBBgwFoAU2kEjnFqP
ca9Xgz4g0+Nl2wzLC9swZQYDVR0fBF4wXDBaoFigVoZUaHR0cDovL3d3dy5pbnRlbC5jb20vcmVw
b3NpdG9yeS9DUkwvSW50ZWwlMjBFeHRlcm5hbCUyMEJhc2ljJTIwSXNzdWluZyUyMENBJTIwNEIu
Y3JsMIGeBggrBgEFBQcBAQSBkTCBjjAhBggrBgEFBQcwAYYVaHR0cDovL29jc3AuaW50ZWwuY29t
MGkGCCsGAQUFBzAChl1odHRwOi8vd3d3LmludGVsLmNvbS9yZXBvc2l0b3J5L2NlcnRpZmljYXRl
cy9JbnRlbCUyMEV4dGVybmFsJTIwQmFzaWMlMjBJc3N1aW5nJTIwQ0ElMjA0Qi5jcnQwCwYDVR0P
BAQDAgeAMDwGCSsGAQQBgjcVBwQvMC0GJSsGAQQBgjcVCIbDjHWEmeVRg/2BKIWOn1OCkcAJZ4He
vTmV8EMCAWQCAQkwHwYDVR0lBBgwFgYIKwYBBQUHAwQGCisGAQQBgjcKAwwwKQYJKwYBBAGCNxUK
BBwwGjAKBggrBgEFBQcDBDAMBgorBgEEAYI3CgMMMEsGA1UdEQREMEKgJwYKKwYBBAGCNxQCA6AZ
DBdpbmdhLnN0b3RsYW5kQGludGVsLmNvbYEXaW5nYS5zdG90bGFuZEBpbnRlbC5jb20wDQYJKoZI
hvcNAQEFBQADggEBALnl11xd+3X6fVS0VAKeoF0jCPLFZLCk4jMFifFzY2md3MLjVIB3lE5ffNnS
mjG9ErOO6as95K6D6hzCJMqNodOyVPRSrMNey0tzFAPLRG3s2bgfmOcvYr4O3WmpDMx8YmH6O2YI
3Xxjyp11aXl5pk6VjpZV/hjN1jwZ/c/X00KsjoMB8mGSBvbwnV0EFQUJ99xsAlqQ4edj2T9z6pF1
WX189YL64c/t3a9LWNaT2CWbBZLIFoor9TpZsIj0lGObmGA76JKn5yxN+jzxhWIAzPi5KKYgJ9EU
FDn6fGbJHisZdWX3bVamfpmPogThm1khlD7R4USu0eyym3JRh0tXJeAxggIXMIICEwIBATCBkDB5
MQswCQYDVQQGEwJVUzELMAkGA1UECBMCQ0ExFDASBgNVBAcTC1NhbnRhIENsYXJhMRowGAYDVQQK
ExFJbnRlbCBDb3Jwb3JhdGlvbjErMCkGA1UEAxMiSW50ZWwgRXh0ZXJuYWwgQmFzaWMgSXNzdWlu
ZyBDQSA0QgITMwAAeRJvGZxlhdnerwAAAAB5EjAJBgUrDgMCGgUAoF0wGAYJKoZIhvcNAQkDMQsG
CSqGSIb3DQEHATAcBgkqhkiG9w0BCQUxDxcNMTkwNTIwMDQxNTEyWjAjBgkqhkiG9w0BCQQxFgQU
qEaHqn5crBtT38ZMdH0zhC1d8TwwDQYJKoZIhvcNAQEBBQAEggEAjj9yeXRWaViTHeNlVbpYmWuH
j95xJ194T+wNWfoRGR/sRCDxJg4N+rtuZ6eB2kDtagxqwTdKeOW2nIUhHg6+nK4H7AOXG/BmD3pW
ZKHmTEdlbMm0E4FmOJ0rA7wkUAK8rrol/eUWMrcs4CAxnRVE+nhh1dFoaIKmVKEluOv928Dk1m0+
7Bxip1/l0f+MARpAuIsWDAF+5RmB0nV+BoBVRGPH7ULWdthPq5faM+88dwpcj3h6k+J/tUKij93C
0dVx9wS4hGg1dB9aWb3X0qpGQSCcOu1UAYzVzR5YrlGqVhKGdITBxrWWQnKQRJ6e9MzXdlWM/Yq+
NQTMyVnKnqgF6gAAAAAAAA==


--=-xCGanzV4VvXTToCl6kLK--
