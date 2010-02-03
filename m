Return-Path: <cyrus@holtmann.org>
Message-ID: <4B69898E.1070001@videam.com.br>
Date: Wed, 03 Feb 2010 12:34:54 -0200
From: "Daniel T. Cobra" <dcobra@videam.com.br>
MIME-Version: 1.0
To: Marcel Holtmann <marcel@holtmann.org>
CC: linux-bluetooth@vger.kernel.org
Subject: Re: Long delay to (re)connect a bluetooth mouse
References: <1260906227.4b27e6f39cc7c@www.fastmail.com.br>	 <4B2A4B90.1040009@videam.com.br>	<4B2BBF58.4030901@videam.com.br>	 <1261173899.4041.96.camel@localhost.localdomain>	 <1261176544.4b2c06e0e0eae@www.fastmail.com.br>	 <1261177111.4041.99.camel@localhost.localdomain>	 <20091223164841.7070e75d@strolchi.home.s3e.de>	 <4B325905.6090103@videam.com.br>	 <20091229160135.12d85fe6@strolchi.home.s3e.de>	 <4B423816.4060405@videam.com.br>	 <20100105115152.506eb191@strolchi.home.s3e.de>	 <4B6961A4.5040503@videam.com.br> <1265206358.31341.109.camel@localhost.localdomain>
In-Reply-To: <1265206358.31341.109.camel@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8; format=flowed
List-ID: <linux-bluetooth.vger.kernel.org>

Thanks, Marcel:

Great! It is starting to make sense. Next, let me ask two questions:

1) You say the information request is needed, but do you mean it is 
needed at every reconnection with the device or, as Stefan suggested, 
would it make sense to request it only when the connection is first 
established and cache the result?

2) Is there a way to know that the device does not support extended 
features, to avoid sending a request that is going to time out without a 
reply? In net/bluetooth/hci_event.c I found this:

1171                if (conn->state == BT_CONFIG) {
1172                        if (!ev->status && lmp_ssp_capable(hdev) &&
1173                                                lmp_ssp_capable(conn)) {
1174                                struct 
hci_cp_read_remote_ext_features cp;
1175                                cp.handle = ev->handle;
1176                                cp.page = 0x01;
1177                                hci_send_cmd(hdev,
1178                                        HCI_OP_READ_REMOTE_EXT_FEATURES,
1179                                                        sizeof(cp), 
&cp);
1180                        } else {
1181                                conn->state = BT_CONNECTED;
1182                                hci_proto_connect_cfm(conn, ev->status);
1183                                hci_conn_put(conn);
1184                        }
1185                }

Is this the right place to look? It seems SSP capability is used as a 
test for whether to read the device's extended features. Is this really 
the best way, or could there be a more suitable indicator of whether the 
device supports extended features, thus avoiding the timeout?

Regards,

Daniel
