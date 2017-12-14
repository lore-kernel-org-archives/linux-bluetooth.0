Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Steve Brown <sbrown@cortland.com>
Message-ID: <1513293681.4409.12.camel@ewol.com>
Subject: meshctl: publish db entry malformed for 2d model of an element
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Date: Thu, 14 Dec 2017 16:21:21 -0700
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

The entries for the second model of an element appear malformed.

This with the current head (813b8e6737ba0c43255979b09a089c44b757a556)

The commands were:

add-appkey 1
bind 0 1 1000
bind 0 1 1001
set-pub 0100 c000 1 0 1001
set-pub 0100 c000 1 0 1000
back
mesh-info

Steve

        "elements":[
          {
            "elementIndex":0,
            "unicastAddress":"0100",
            "models":[
              {
                "modelId":"1000",
                "bind":[
                  1
                ],
                "publish":{
                  "address":"c000",
                  "index":"0001",
                  "ttl":255
                }
              },
              {
                "modelId":"1001",
                "bind":[
                  1
                ]
              },
              {
                "modelId":"1001",
                "publish":{
                  "address":"c000",
                  "index":"0001",
                  "ttl":255
                }
              }
            ]
          },
          {
