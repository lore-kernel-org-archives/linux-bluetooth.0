Received: from server.interlinx.bc.ca (mail.interlinx.bc.ca [69.165.217.196])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 908F936084
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Dec 2023 14:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=interlinx.bc.ca
Authentication-Results: smtp.subspace.kernel.org; spf=fail smtp.mailfrom=interlinx.bc.ca
Received: from brian-laptop.interlinx.bc.ca (unknown [IPv6:fd0c:685d:4db3:4ba7:23ab:92fe:41d5:f62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by server.interlinx.bc.ca (Postfix) with ESMTPSA id CBD2E2F748
	for <linux-bluetooth@vger.kernel.org>; Thu, 21 Dec 2023 09:12:50 -0500 (EST)
Message-ID: <da55cd171a7055f3438447947f36723e9e539547.camel@interlinx.bc.ca>
Subject: Re: chrome passkey communication timing out
From: "Brian J. Murrell" <brian@interlinx.bc.ca>
To: linux-bluetooth@vger.kernel.org
Date: Thu, 21 Dec 2023 09:12:50 -0500
In-Reply-To: <CABBYNZLbyCkg+heU5gNDooo2w7Uf+P1To0pVnrhS_z7Be3bTYw@mail.gmail.com>
References: <6ce4dab33868db0a8c7b93bf58c20aa876d50f21.camel@interlinx.bc.ca>
	 <CABBYNZLbyCkg+heU5gNDooo2w7Uf+P1To0pVnrhS_z7Be3bTYw@mail.gmail.com>
Content-Type: text/plain; charset="ISO-8859-15"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.50.2 (3.50.2-1.fc39) 
Precedence: bulk
X-Mailing-List: linux-bluetooth@vger.kernel.org
List-Id: <linux-bluetooth.vger.kernel.org>
List-Subscribe: <mailto:linux-bluetooth+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-bluetooth+unsubscribe@vger.kernel.org>
MIME-Version: 1.0

On Tue, 2023-12-19 at 12:49 -0500, Luiz Augusto von Dentz wrote:
> Hi Brian,

Hi Luiz.

> Check with btmon what if that is generating any traffic.

Ah, yes.  btmon.  Forgot all about that.

Bluetooth monitor ver 5.71
=3D Note: Linux version 6.5.11-300.fc39.x86_64 (x86_64)                    =
                                                                           =
                         0.208407
=3D Note: Bluetooth subsystem version 2.22                                 =
                                                                           =
                         0.208411
=3D New Index: 70:F3:95:3E:92:34 (Primary,USB,hci0)                        =
                                                                           =
                  [hci0] 0.208412
=3D Open Index: 70:F3:95:3E:92:34                                          =
                                                                           =
                  [hci0] 0.208413
=3D Index Info: 70:F3:95:3E:92:34 (Broadcom Corporation)                   =
                                                                           =
                  [hci0] 0.208414
@ MGMT Open: bluetoothd (privileged) version 1.22                          =
                                                                           =
              {0x0001} 0.208415
@ MGMT Command: Start Service Discovery (0x003a) plen 4                    =
                                                                           =
      {0x0001} [hci0] 24.471901
        Address type: 0x06
          LE Public
          LE Random
        RSSI: invalid (0x7f)
        UUIDs: 0
@ MGMT Event: Command Complete (0x0001) plen 4                             =
                                                                           =
      {0x0001} [hci0] 24.471919
      Start Service Discovery (0x003a) plen 1
        Status: Not Supported (0x0c)
        Address type: 0x06
          LE Public
          LE Rando
The "Not Supported" is not entirely lost on me.  But what exactly is
not supported?

Cheers,
b.

