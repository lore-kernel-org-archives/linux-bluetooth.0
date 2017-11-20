Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: =?utf-8?Q?Micha=C5=82_Hobot?= <michal.hobot@silvair.com>
Content-Type: multipart/mixed;
 boundary="Apple-Mail=_53932FFF-7DE0-45F5-953F-F519CFAEC280"
Mime-Version: 1.0 (Mac OS X Mail 10.3 \(3273\))
Subject: meshctl cannot parse its own config file
Message-Id: <D4221F5B-37CC-4BAA-88F3-C7B7F2E98DA2@silvair.com>
Date: Mon, 20 Nov 2017 19:19:49 +0100
To: linux-bluetooth@vger.kernel.org
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>


--Apple-Mail=_53932FFF-7DE0-45F5-953F-F519CFAEC280
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain;
	charset=us-ascii

Hi,
I'm testing meshctl of bluez 5.47 with a lighting device with Silvair =
mesh stack.
I am able to provision a device using a following sequence of commands:

provision a9d8....(UUID follows)
add-appkey 1
bind 0 1 1000

Im then able to turn the light on and off using onoff 1 / onoff 0. Get =
also works.

When I'm leaving meshctl and start it once again, it fails while parsing =
provisioner_db.json

I found out that the problem was caused by:

"bind":[
  1
]

in nodes/elements/models
When I remove "bind" element, everything seems to work fine.

Is it a bug in the software or am I doing something wrong?

Attaching configuration files.

Regards,
Michal Hobot


--Apple-Mail=_53932FFF-7DE0-45F5-953F-F519CFAEC280
Content-Disposition: attachment;
	filename=local_node.json
Content-Type: application/json;
	x-unix-mode=0644;
	name="local_node.json"
Content-Transfer-Encoding: 7bit

{
  "$schema":"file:\/\/\/BlueZ\/Mesh\/local_schema\/mesh.jsonschema",
  "meshName":"BT Mesh",
  "netKeys":[
    {
      "index":0,
      "keyRefresh":0
    }
  ],
  "appKeys":[
    {
      "index":0,
      "boundNetKey":0
    },
    {
      "index":1,
      "boundNetKey":0
    }
  ],
  "node":{
    "composition":{
      "cid":"0002",
      "pid":"0010",
      "vid":"0001",
      "crpl":"000a",
      "features":{
        "relay":false,
        "proxy":true,
        "friend":false,
        "lowPower":false
      },
      "elements":[
        {
          "elementIndex":0,
          "location":"0001",
          "models":[
            "0000",
            "0001",
            "1001"
          ]
        }
      ]
    },
    "configuration":{
      "netKeys":[
        0
      ],
      "appKeys":[
        0,
        1
      ],
      "defaultTTL":10,
      "elements":[
        {
          "elementIndex":0,
          "unicastAddress":"0077",
          "models":[
            {
              "modelId":"1001",
              "bind":[
                1
              ]
            }
          ]
        }
      ]
    },
    "IVindex":5,
    "IVupdate":0,
    "sequenceNumber":403
  }
}
--Apple-Mail=_53932FFF-7DE0-45F5-953F-F519CFAEC280
Content-Disposition: attachment;
	filename=prov_db.json
Content-Type: application/json;
	x-unix-mode=0644;
	name="prov_db.json"
Content-Transfer-Encoding: 7bit

{
  "$schema":"file:\/\/\/BlueZ\/Mesh\/schema\/mesh.jsonschema",
  "meshName":"BT Mesh",
  "netKeys":[
    {
      "index":0,
      "keyRefresh":0,
      "key":"18eed9c2a56add85049ffc3c59ad0e12"
    }
  ],
  "appKeys":[
    {
      "index":0,
      "boundNetKey":0,
      "key":"4f68ad85d9f48ac8589df665b6b49b8a"
    },
    {
      "index":1,
      "boundNetKey":0,
      "key":"2aa2a6ded5a0798ceab5787ca3ae39fc"
    }
  ],
  "provisioners":[
    {
      "provisionerName":"BT Mesh Provisioner",
      "unicastAddress":"0077",
      "allocatedUnicastRange":[
        {
          "lowAddress":"0100",
          "highAddress":"7fff"
        }
      ]
    }
  ],
  "nodes":[
    {
      "deviceKey":"11544223b5bf041965ef002d14255116",
      "configuration":{
        "netKeys":[
          "0000"
        ],
        "elements":[
          {
            "elementIndex":0,
            "unicastAddress":"0100",
            "models":[
              {
                "modelId":"1000",
                "bind":[
                  1
                ]
              }
            ]
          },
          {
            "elementIndex":1,
            "unicastAddress":"0101"
          }
        ],
        "appKeys":[
          "0001"
        ],
        "defaultTTL":4
      },
      "IVindex":5,
      "sequenceNumber":25
    }
  ],
  "IVindex":5,
  "IVupdate":0
}

--Apple-Mail=_53932FFF-7DE0-45F5-953F-F519CFAEC280--
