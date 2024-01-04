Received: from server.interlinx.bc.ca (mail.interlinx.bc.ca [69.165.217.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8398B2230B
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jan 2024 13:13:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=interlinx.bc.ca
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=interlinx.bc.ca
Received: from pc.interlinx.bc.ca (pc.interlinx.bc.ca [IPv6:fd31:aeb1:48df:0:3b14:e643:83d8:7017])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by server.interlinx.bc.ca (Postfix) with ESMTPSA id 927E325A81
	for <linux-bluetooth@vger.kernel.org>; Thu,  4 Jan 2024 08:13:48 -0500 (EST)
Message-ID: <30fb108034be78c04ff195dba6708aa9d881bf75.camel@interlinx.bc.ca>
Subject: Re: Unable to connect BT mouse after it drops: Failed to connect:
 org.bluez.Error.Failed br-connection-create-socket
From: "Brian J. Murrell" <brian@interlinx.bc.ca>
To: linux-bluetooth@vger.kernel.org
Date: Thu, 04 Jan 2024 08:13:48 -0500
In-Reply-To: <CABBYNZKS0BZGRZ8NMjue91i_P3mtQSL=ctLDcHDiZ+BBcXL2Aw@mail.gmail.com>
References: <85bf602dac47b63cfc5ec772fddcedbce29c13df.camel@interlinx.bc.ca>
	 <548cbe00abc60f0506dbc47802bddd276c192205.camel@interlinx.bc.ca>
	 <CABBYNZKS0BZGRZ8NMjue91i_P3mtQSL=ctLDcHDiZ+BBcXL2Aw@mail.gmail.com>
Autocrypt: addr=brian@interlinx.bc.ca; prefer-encrypt=mutual;
 keydata=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
Content-Type: multipart/signed; micalg="pgp-sha256";
	protocol="application/pgp-signature"; boundary="=-skb7a0hpwLpx9fsVP+b2"
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0


--=-skb7a0hpwLpx9fsVP+b2
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, 2024-01-03 at 11:08 -0500, Luiz Augusto von Dentz wrote:
> Hi Brian,
>=20
> This usually means the device cannot be found, we receive a page
> timeout, so Im not really sure why replugging would have fixed it,
> could you please collect the HCI trace using btmon when that happens
> so we can inspect the error it is returning.

As far as the terminal's scrollback buffer goes, here's what btmon
reported:

      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.808029
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.808030
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.808075
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.808076
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.808119
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.808120
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.808173
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.808174
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.809737
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.809741
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.809795
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.809797
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.809846
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.809850
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.809897
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.809898
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.809943
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.809944
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.809990
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.809991
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.810036
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.810037
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.810082
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.810083
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.810128
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.810130
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.810176
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.810176
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.810220
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.810221
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.810264
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.810266
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.810309
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.810310
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.810361
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.810362
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.810410
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.810412
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.810457
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.810458
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.810504
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.810505
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.810551
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.810551
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.810595
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.810597
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.810640
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.810641
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.810684
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.810686
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.810774
        Powered: Disabled (0x00)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.810863
        Powered: Disabled (0x00)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.810906
        Powered: Disabled (0x00)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.810995
        Powered: Disabled (0x00)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.811040
        Powered: Disabled (0x00)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.811128
        Powered: Disabled (0x00)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.811217
        Powered: Disabled (0x00)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.811262
        Powered: Disabled (0x00)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.811351
        Powered: Disabled (0x00)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.811416
        Powered: Disabled (0x00)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.811463
        Powered: Disabled (0x00)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.811508
        Powered: Disabled (0x00)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.811551
        Powered: Disabled (0x00)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.811596
        Powered: Disabled (0x00)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.811640
        Powered: Disabled (0x00)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.811685
        Powered: Disabled (0x00)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.811730
        Powered: Disabled (0x00)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.811774
        Powered: Disabled (0x00)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.811818
        Powered: Disabled (0x00)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.811863
        Powered: Disabled (0x00)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.811908
        Powered: Disabled (0x00)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.811953
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.811955
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.812000
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.812001
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.812044
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.812045
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.812088
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.812089
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.812132
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.812133
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.812177
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.812178
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.812222
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.812223
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.812267
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.812268
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.812311
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.812312
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.812362
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.812363
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.812409
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.812410
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.812454
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.812455
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.812499
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.812499
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.812542
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.812543
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.812586
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.812587
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.812630
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.812631
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.812674
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.812675
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.812718
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.812719
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.812763
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.812764
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.812807
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.812808
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.812852
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.812853
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.812896
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.812898
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.812942
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.812943
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.812987
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.812988
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.813040
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.813041
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.813087
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.813088
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.813132
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.813133
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.813176
        Powered: Disabled (0x00)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.813220
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.813221
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.813264
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.813266
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.813311
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.813312
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.813360
        Powered: Disabled (0x00)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.815652
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.815655
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.815731
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.815732
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.815782
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.815784
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.815866
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.815867
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.815935
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.815937
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.815985
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.815988
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.816035
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.816036
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.816082
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.816084
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.816130
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.816130
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.816177
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.816178
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.816222
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.816223
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.816268
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.816269
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.816314
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.816315
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.816374
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.816375
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.816424
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.816425
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.816471
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.816472
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.816517
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.816518
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.816563
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.816564
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.816608
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.816609
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.816653
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.816654
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.816698
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.816698
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.816743
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.816744
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.816789
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.816790
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.816835
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.816836
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.816881
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.816882
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.816927
        Powered: Disabled (0x00)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.824293
        Powered: Disabled (0x00)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.824337
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.824338
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.824481
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.824482
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.824537
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.824539
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.825229
        Powered: Disabled (0x00)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.826344
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.826348
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.826419
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.826422
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.826576
        Powered: Disabled (0x00)
@ MGMT Event: Command Status (0x0002) plen 3                               =
                                                        {0x0002} [hci0] 822=
29.826578
      Set Powered (0x0005)
        Status: Permission Denied (0x14)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.826722
        Powered: Disabled (0x00)
hass[1670495]: @ MGMT Command: Set Powered (0x0005) plen 1                 =
                                                        {0x0002} [hci0] 822=
29.826986
        Powered: Disabled (0x00)
hass[1670495]: @ MGMT Close: hass                                          =
                                                               {0x0002} 822=
29.827779
bluetoothd[316342]: @ MGMT Command: Start Service Discovery (0x003a) plen 4=
                                                        {0x0001} [hci0] 822=
34.836190
        Address type: 0x06
          LE Public
          LE Random
        RSSI: invalid (0x7f)
        UUIDs: 0
< HCI Command: LE Set Random Address (0x08|0x0005) plen 6                  =
                                                         #367466 [hci0] 822=
34.836314
        Address: 08:41:1D:9D:AF:7D (Non-Resolvable)
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                         #367467 [hci0] 822=
34.837461
      LE Set Random Address (0x08|0x0005) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Extended Scan Parameters (0x08|0x0041) plen 13       =
                                                         #367468 [hci0] 822=
34.837520
        Own address type: Random (0x01)
        Filter policy: Accept all advertisement (0x00)
        PHYs: 0x05
        Entry 0: LE 1M
          Type: Active (0x01)
          Interval: 11.250 msec (0x0012)
          Window: 11.250 msec (0x0012)
        Entry 1: LE Coded
          Type: Active (0x01)
          Interval: 11.250 msec (0x0012)
          Window: 11.250 msec (0x0012)
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                         #367469 [hci0] 822=
34.838462
      LE Set Extended Scan Parameters (0x08|0x0041) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6            =
                                                         #367470 [hci0] 822=
34.838629
        Extended scan: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
        Duration: 0 msec (0x0000)
        Period: 0.00 sec (0x0000)
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                         #367471 [hci0] 822=
34.839460
      LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
        Status: Success (0x00)
@ MGMT Event: Command Complete (0x0001) plen 4                             =
                                                        {0x0001} [hci0] 822=
34.839510
      Start Service Discovery (0x003a) plen 1
        Status: Success (0x00)
        Address type: 0x06
          LE Public
          LE Random
@ MGMT Event: Discovering (0x0013) plen 2                                  =
                                                        {0x0001} [hci0] 822=
34.839520
        Address type: 0x06
          LE Public
          LE Random
        Discovery: Enabled (0x01)
@ MGMT Event: Discovering (0x0013) plen 2                                  =
                                                        {0x0001} [hci0] 822=
45.539431
        Address type: 0x06
          LE Public
          LE Random
        Discovery: Disabled (0x00)
bluetoothd[316342]: @ MGMT Command: Start Service Discovery (0x003a) plen 4=
                                                        {0x0001} [hci0] 822=
45.539633
        Address type: 0x06
          LE Public
          LE Random
        RSSI: invalid (0x7f)
        UUIDs: 0
< HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6            =
                                                         #367472 [hci0] 822=
45.539715
        Extended scan: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
        Duration: 0 msec (0x0000)
        Period: 0.00 sec (0x0000)
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                         #367473 [hci0] 822=
45.541515
      LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Random Address (0x08|0x0005) plen 6                  =
                                                         #367474 [hci0] 822=
45.541697
        Address: 3C:E9:D3:2A:B0:E1 (Non-Resolvable)
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                         #367475 [hci0] 822=
45.542480
      LE Set Random Address (0x08|0x0005) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Extended Scan Parameters (0x08|0x0041) plen 13       =
                                                         #367476 [hci0] 822=
45.542626
        Own address type: Random (0x01)
        Filter policy: Accept all advertisement (0x00)
        PHYs: 0x05
        Entry 0: LE 1M
          Type: Active (0x01)
          Interval: 11.250 msec (0x0012)
          Window: 11.250 msec (0x0012)
        Entry 1: LE Coded
          Type: Active (0x01)
          Interval: 11.250 msec (0x0012)
          Window: 11.250 msec (0x0012)
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                         #367477 [hci0] 822=
45.543473
      LE Set Extended Scan Parameters (0x08|0x0041) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6            =
                                                         #367478 [hci0] 822=
45.543535
        Extended scan: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
        Duration: 0 msec (0x0000)
        Period: 0.00 sec (0x0000)
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                         #367479 [hci0] 822=
45.544474
      LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
        Status: Success (0x00)
@ MGMT Event: Command Complete (0x0001) plen 4                             =
                                                        {0x0001} [hci0] 822=
45.544528
      Start Service Discovery (0x003a) plen 1
        Status: Success (0x00)
        Address type: 0x06
          LE Public
          LE Random
@ MGMT Event: Discovering (0x0013) plen 2                                  =
                                                        {0x0001} [hci0] 822=
45.544544
        Address type: 0x06
          LE Public
          LE Random
        Discovery: Enabled (0x01)
@ MGMT Event: Discovering (0x0013) plen 2                                  =
                                                        {0x0001} [hci0] 822=
56.291425
        Address type: 0x06
          LE Public
          LE Random
        Discovery: Disabled (0x00)
bluetoothd[316342]: @ MGMT Command: Start Service Discovery (0x003a) plen 4=
                                                        {0x0001} [hci0] 822=
56.291542
        Address type: 0x06
          LE Public
          LE Random
        RSSI: invalid (0x7f)
        UUIDs: 0
< HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6            =
                                                         #367480 [hci0] 822=
56.291585
        Extended scan: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
        Duration: 0 msec (0x0000)
        Period: 0.00 sec (0x0000)
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                         #367481 [hci0] 822=
56.292478
      LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Random Address (0x08|0x0005) plen 6                  =
                                                         #367482 [hci0] 822=
56.292508
        Address: 20:71:E0:59:A4:B6 (Non-Resolvable)
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                         #367483 [hci0] 822=
56.293479
      LE Set Random Address (0x08|0x0005) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Extended Scan Parameters (0x08|0x0041) plen 13       =
                                                         #367484 [hci0] 822=
56.293506
        Own address type: Random (0x01)
        Filter policy: Accept all advertisement (0x00)
        PHYs: 0x05
        Entry 0: LE 1M
          Type: Active (0x01)
          Interval: 11.250 msec (0x0012)
          Window: 11.250 msec (0x0012)
        Entry 1: LE Coded
          Type: Active (0x01)
          Interval: 11.250 msec (0x0012)
          Window: 11.250 msec (0x0012)
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                         #367485 [hci0] 822=
56.294480
      LE Set Extended Scan Parameters (0x08|0x0041) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6            =
                                                         #367486 [hci0] 822=
56.294508
        Extended scan: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
        Duration: 0 msec (0x0000)
        Period: 0.00 sec (0x0000)
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                         #367487 [hci0] 822=
56.295481
      LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
        Status: Success (0x00)
@ MGMT Event: Command Complete (0x0001) plen 4                             =
                                                        {0x0001} [hci0] 822=
56.295510
      Start Service Discovery (0x003a) plen 1
        Status: Success (0x00)
        Address type: 0x06
          LE Public
          LE Random
@ MGMT Event: Discovering (0x0013) plen 2                                  =
                                                        {0x0001} [hci0] 822=
56.295516
        Address type: 0x06
          LE Public
          LE Random
        Discovery: Enabled (0x01)
@ MGMT Event: Discovering (0x0013) plen 2                                  =
                                                        {0x0001} [hci0] 822=
67.043402
        Address type: 0x06
          LE Public
          LE Random
        Discovery: Disabled (0x00)
< HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6            =
                                                         #367488 [hci0] 822=
67.043429
        Extended scan: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
        Duration: 0 msec (0x0000)
        Period: 0.00 sec (0x0000)
bluetoothd[316342]: @ MGMT Command: Start Service Discovery (0x003a) plen 4=
                                                        {0x0001} [hci0] 822=
67.043648
        Address type: 0x06
          LE Public
          LE Random
        RSSI: invalid (0x7f)
        UUIDs: 0
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                         #367489 [hci0] 822=
67.044496
      LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Random Address (0x08|0x0005) plen 6                  =
                                                         #367490 [hci0] 822=
67.044538
        Address: 2C:79:E8:CD:31:39 (Non-Resolvable)
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                         #367491 [hci0] 822=
67.045494
      LE Set Random Address (0x08|0x0005) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Extended Scan Parameters (0x08|0x0041) plen 13       =
                                                         #367492 [hci0] 822=
67.045589
        Own address type: Random (0x01)
        Filter policy: Accept all advertisement (0x00)
        PHYs: 0x05
        Entry 0: LE 1M
          Type: Active (0x01)
          Interval: 11.250 msec (0x0012)
          Window: 11.250 msec (0x0012)
        Entry 1: LE Coded
          Type: Active (0x01)
          Interval: 11.250 msec (0x0012)
          Window: 11.250 msec (0x0012)
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                         #367493 [hci0] 822=
67.046492
      LE Set Extended Scan Parameters (0x08|0x0041) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6            =
                                                         #367494 [hci0] 822=
67.046520
        Extended scan: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
        Duration: 0 msec (0x0000)
        Period: 0.00 sec (0x0000)
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                         #367495 [hci0] 822=
67.047491
      LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
        Status: Success (0x00)
@ MGMT Event: Command Complete (0x0001) plen 4                             =
                                                        {0x0001} [hci0] 822=
67.047511
      Start Service Discovery (0x003a) plen 1
        Status: Success (0x00)
        Address type: 0x06
          LE Public
          LE Random
@ MGMT Event: Discovering (0x0013) plen 2                                  =
                                                        {0x0001} [hci0] 822=
67.047518
        Address type: 0x06
          LE Public
          LE Random
        Discovery: Enabled (0x01)
@ MGMT Event: Discovering (0x0013) plen 2                                  =
                                                        {0x0001} [hci0] 822=
77.795520
        Address type: 0x06
          LE Public
          LE Random
        Discovery: Disabled (0x00)
< HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6            =
                                                         #367496 [hci0] 822=
77.795582
        Extended scan: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
        Duration: 0 msec (0x0000)
        Period: 0.00 sec (0x0000)
bluetoothd[316342]: @ MGMT Command: Start Service Discovery (0x003a) plen 4=
                                                        {0x0001} [hci0] 822=
77.795836
        Address type: 0x06
          LE Public
          LE Random
        RSSI: invalid (0x7f)
        UUIDs: 0
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                         #367497 [hci0] 822=
77.796539
      LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Random Address (0x08|0x0005) plen 6                  =
                                                         #367498 [hci0] 822=
77.796616
        Address: 3E:BB:14:E4:83:A6 (Non-Resolvable)
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                         #367499 [hci0] 822=
77.797521
      LE Set Random Address (0x08|0x0005) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Extended Scan Parameters (0x08|0x0041) plen 13       =
                                                         #367500 [hci0] 822=
77.797594
        Own address type: Random (0x01)
        Filter policy: Accept all advertisement (0x00)
        PHYs: 0x05
        Entry 0: LE 1M
          Type: Active (0x01)
          Interval: 11.250 msec (0x0012)
          Window: 11.250 msec (0x0012)
        Entry 1: LE Coded
          Type: Active (0x01)
          Interval: 11.250 msec (0x0012)
          Window: 11.250 msec (0x0012)
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                         #367501 [hci0] 822=
77.798513
      LE Set Extended Scan Parameters (0x08|0x0041) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6            =
                                                         #367502 [hci0] 822=
77.798567
        Extended scan: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
        Duration: 0 msec (0x0000)
        Period: 0.00 sec (0x0000)
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                         #367503 [hci0] 822=
77.799514
      LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
        Status: Success (0x00)
@ MGMT Event: Command Complete (0x0001) plen 4                             =
                                                        {0x0001} [hci0] 822=
77.799564
      Start Service Discovery (0x003a) plen 1
        Status: Success (0x00)
        Address type: 0x06
          LE Public
          LE Random
@ MGMT Event: Discovering (0x0013) plen 2                                  =
                                                        {0x0001} [hci0] 822=
77.799578
        Address type: 0x06
          LE Public
          LE Random
        Discovery: Enabled (0x01)
@ MGMT Event: Discovering (0x0013) plen 2                                  =
                                                        {0x0001} [hci0] 822=
88.548526
        Address type: 0x06
          LE Public
          LE Random
        Discovery: Disabled (0x00)
< HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6            =
                                                         #367504 [hci0] 822=
88.548716
        Extended scan: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
        Duration: 0 msec (0x0000)
        Period: 0.00 sec (0x0000)
bluetoothd[316342]: @ MGMT Command: Start Service Discovery (0x003a) plen 4=
                                                        {0x0001} [hci0] 822=
88.548895
        Address type: 0x06
          LE Public
          LE Random
        RSSI: invalid (0x7f)
        UUIDs: 0
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                         #367505 [hci0] 822=
88.550525
      LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Random Address (0x08|0x0005) plen 6                  =
                                                         #367506 [hci0] 822=
88.550570
        Address: 09:DC:C1:82:DB:1D (Non-Resolvable)
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                         #367507 [hci0] 822=
88.551527
      LE Set Random Address (0x08|0x0005) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Extended Scan Parameters (0x08|0x0041) plen 13       =
                                                         #367508 [hci0] 822=
88.551589
        Own address type: Random (0x01)
        Filter policy: Accept all advertisement (0x00)
        PHYs: 0x05
        Entry 0: LE 1M
          Type: Active (0x01)
          Interval: 11.250 msec (0x0012)
          Window: 11.250 msec (0x0012)
        Entry 1: LE Coded
          Type: Active (0x01)
          Interval: 11.250 msec (0x0012)
          Window: 11.250 msec (0x0012)
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                         #367509 [hci0] 822=
88.552531
      LE Set Extended Scan Parameters (0x08|0x0041) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6            =
                                                         #367510 [hci0] 822=
88.552564
        Extended scan: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
        Duration: 0 msec (0x0000)
        Period: 0.00 sec (0x0000)
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                         #367511 [hci0] 822=
88.553525
      LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
        Status: Success (0x00)
@ MGMT Event: Command Complete (0x0001) plen 4                             =
                                                        {0x0001} [hci0] 822=
88.553556
      Start Service Discovery (0x003a) plen 1
        Status: Success (0x00)
        Address type: 0x06
          LE Public
          LE Random
@ MGMT Event: Discovering (0x0013) plen 2                                  =
                                                        {0x0001} [hci0] 822=
88.553565
        Address type: 0x06
          LE Public
          LE Random
        Discovery: Enabled (0x01)
@ MGMT Event: Discovering (0x0013) plen 2                                  =
                                                        {0x0001} [hci0] 822=
99.299414
        Address type: 0x06
          LE Public
          LE Random
        Discovery: Disabled (0x00)
< HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6            =
                                                         #367512 [hci0] 822=
99.299480
        Extended scan: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
        Duration: 0 msec (0x0000)
        Period: 0.00 sec (0x0000)
bluetoothd[316342]: @ MGMT Command: Start Service Discovery (0x003a) plen 4=
                                                        {0x0001} [hci0] 822=
99.300458
        Address type: 0x06
          LE Public
          LE Random
        RSSI: invalid (0x7f)
        UUIDs: 0
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                         #367513 [hci0] 822=
99.300544
      LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Random Address (0x08|0x0005) plen 6                  =
                                                         #367514 [hci0] 822=
99.300875
        Address: 2E:DA:B6:D0:18:E3 (Non-Resolvable)
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                         #367515 [hci0] 822=
99.301537
      LE Set Random Address (0x08|0x0005) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Extended Scan Parameters (0x08|0x0041) plen 13       =
                                                         #367516 [hci0] 822=
99.301605
        Own address type: Random (0x01)
        Filter policy: Accept all advertisement (0x00)
        PHYs: 0x05
        Entry 0: LE 1M
          Type: Active (0x01)
          Interval: 11.250 msec (0x0012)
          Window: 11.250 msec (0x0012)
        Entry 1: LE Coded
          Type: Active (0x01)
          Interval: 11.250 msec (0x0012)
          Window: 11.250 msec (0x0012)
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                         #367517 [hci0] 822=
99.302538
      LE Set Extended Scan Parameters (0x08|0x0041) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6            =
                                                         #367518 [hci0] 822=
99.302663
        Extended scan: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
        Duration: 0 msec (0x0000)
        Period: 0.00 sec (0x0000)
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                         #367519 [hci0] 822=
99.303537
      LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
        Status: Success (0x00)
@ MGMT Event: Command Complete (0x0001) plen 4                             =
                                                        {0x0001} [hci0] 822=
99.303594
      Start Service Discovery (0x003a) plen 1
        Status: Success (0x00)
        Address type: 0x06
          LE Public
          LE Random
@ MGMT Event: Discovering (0x0013) plen 2                                  =
                                                        {0x0001} [hci0] 822=
99.303609
        Address type: 0x06
          LE Public
          LE Random
        Discovery: Enabled (0x01)

@ MGMT Event: Discovering (0x0013) plen 2                                  =
                                                        {0x0001} [hci0] 823=
10.051380
        Address type: 0x06
          LE Public
          LE Random
        Discovery: Disabled (0x00)
bluetoothd[316342]: @ MGMT Command: Start Service Discovery (0x003a) plen 4=
                                                        {0x0001} [hci0] 823=
10.051492
        Address type: 0x06
          LE Public
          LE Random
        RSSI: invalid (0x7f)
        UUIDs: 0
< HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6            =
                                                         #367520 [hci0] 823=
10.051566
        Extended scan: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
        Duration: 0 msec (0x0000)
        Period: 0.00 sec (0x0000)
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                         #367521 [hci0] 823=
10.052547
      LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Random Address (0x08|0x0005) plen 6                  =
                                                         #367522 [hci0] 823=
10.052583
        Address: 38:E4:B1:E7:A0:E0 (Non-Resolvable)
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                         #367523 [hci0] 823=
10.053547
      LE Set Random Address (0x08|0x0005) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Extended Scan Parameters (0x08|0x0041) plen 13       =
                                                         #367524 [hci0] 823=
10.053577
        Own address type: Random (0x01)
        Filter policy: Accept all advertisement (0x00)
        PHYs: 0x05
        Entry 0: LE 1M
          Type: Active (0x01)
          Interval: 11.250 msec (0x0012)
          Window: 11.250 msec (0x0012)
        Entry 1: LE Coded
          Type: Active (0x01)
          Interval: 11.250 msec (0x0012)
          Window: 11.250 msec (0x0012)
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                         #367525 [hci0] 823=
10.054549
      LE Set Extended Scan Parameters (0x08|0x0041) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6            =
                                                         #367526 [hci0] 823=
10.054581
        Extended scan: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
        Duration: 0 msec (0x0000)
        Period: 0.00 sec (0x0000)
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                         #367527 [hci0] 823=
10.055548
      LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
        Status: Success (0x00)
@ MGMT Event: Command Complete (0x0001) plen 4                             =
                                                        {0x0001} [hci0] 823=
10.055580
      Start Service Discovery (0x003a) plen 1
        Status: Success (0x00)
        Address type: 0x06
          LE Public
          LE Random
@ MGMT Event: Discovering (0x0013) plen 2                                  =
                                                        {0x0001} [hci0] 823=
10.055587
        Address type: 0x06
          LE Public
          LE Random
        Discovery: Enabled (0x01)
@ MGMT Event: Discovering (0x0013) plen 2                                  =
                                                        {0x0001} [hci0] 823=
20.803388
        Address type: 0x06
          LE Public
          LE Random
        Discovery: Disabled (0x00)
< HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6            =
                                                         #367528 [hci0] 823=
20.803419
        Extended scan: Disabled (0x00)
        Filter duplicates: Disabled (0x00)
        Duration: 0 msec (0x0000)
        Period: 0.00 sec (0x0000)
bluetoothd[316342]: @ MGMT Command: Start Service Discovery (0x003a) plen 4=
                                                        {0x0001} [hci0] 823=
20.803699
        Address type: 0x06
          LE Public
          LE Random
        RSSI: invalid (0x7f)
        UUIDs: 0
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                         #367529 [hci0] 823=
20.804567
      LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Random Address (0x08|0x0005) plen 6                  =
                                                         #367530 [hci0] 823=
20.804615
        Address: 18:89:DE:25:B6:1E (Non-Resolvable)
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                         #367531 [hci0] 823=
20.805565
      LE Set Random Address (0x08|0x0005) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Extended Scan Parameters (0x08|0x0041) plen 13       =
                                                         #367532 [hci0] 823=
20.805609
        Own address type: Random (0x01)
        Filter policy: Accept all advertisement (0x00)
        PHYs: 0x05
        Entry 0: LE 1M
          Type: Active (0x01)
          Interval: 11.250 msec (0x0012)
          Window: 11.250 msec (0x0012)
        Entry 1: LE Coded
          Type: Active (0x01)
          Interval: 11.250 msec (0x0012)
          Window: 11.250 msec (0x0012)
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                         #367533 [hci0] 823=
20.806562
      LE Set Extended Scan Parameters (0x08|0x0041) ncmd 2
        Status: Success (0x00)
< HCI Command: LE Set Extended Scan Enable (0x08|0x0042) plen 6            =
                                                         #367534 [hci0] 823=
20.806613
        Extended scan: Enabled (0x01)
        Filter duplicates: Enabled (0x01)
        Duration: 0 msec (0x0000)
        Period: 0.00 sec (0x0000)
> HCI Event: Command Complete (0x0e) plen 4                                =
                                                         #367535 [hci0] 823=
20.807563
      LE Set Extended Scan Enable (0x08|0x0042) ncmd 2
        Status: Success (0x00)
@ MGMT Event: Command Complete (0x0001) plen 4                             =
                                                        {0x0001} [hci0] 823=
20.807593
      Start Service Discovery (0x003a) plen 1
        Status: Success (0x00)
        Address type: 0x06
          LE Public
          LE Random
@ MGMT Event: Discovering (0x0013) plen 2                                  =
                                                        {0x0001} [hci0] 823=
20.807603
        Address type: 0x06
          LE Public
          LE Random
        Discovery: Enabled (0x01)

I suspect that's not far enough back though.  :-(

The adapter is still in that broken state.  I will leave it that way as
long as I can in case there is something you want me to do while it's
in that broken state.

Cheers,
b.



--=-skb7a0hpwLpx9fsVP+b2
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEE8B/A+mOVz5cTNBuZ2sHQNBbLyKAFAmWWrwwACgkQ2sHQNBbL
yKDrJwf/Q3sqvpfPXduk/ZlnW7kUdQR1dOPY9OXrlGvLiuQ+b4XN3rH8gzZpwRE1
VWXmF4DxGha2164boS2HEVUiaKAjiicKeEQG9mZgADuSNbnMImyVozbY22t4QNq1
ww7EIDNBTofzYZ61SWnkfDXIpI5+BzzyACVr+0PZHT2MnxjDCSq5mr6vJOh9WTAu
qC1RVzUCXclqGgYTtvIwU3PX3IajO9vZL0RCWnaHlFmi+EgNJlLGO2aObvdZW3jC
+npoLn4C5/J0m7Euapf4tkpdFWXh5o0L1hYLXpYfN6HJbaY/1noiFxk6l99R8l0A
4hmynXZ12cGu61o5KdaYwHApHkvGWg==
=wiMW
-----END PGP SIGNATURE-----

--=-skb7a0hpwLpx9fsVP+b2--
