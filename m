Return-Path: <linux-bluetooth-owner@vger.kernel.org>
From: Steve Brown <sbrown@cortland.com>
Message-ID: <1513336488.18172.20.camel@ewol.com>
Subject: Re: meshctl: publish db entry malformed for 2d model of an element
To: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Cc: Steve Brown <sbrown@cortland.com>
Date: Fri, 15 Dec 2017 04:14:48 -0700
In-Reply-To: <1513293681.4409.12.camel@ewol.com>
References: <1513293681.4409.12.camel@ewol.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

On Thu, 2017-12-14 at 16:21 -0700, Steve Brown wrote:
> The entries for the second model of an element appear malformed.
> 
> This with the current head (813b8e6737ba0c43255979b09a089c44b757a556)
> 
> The commands were:
> 
> add-appkey 1
> bind 0 1 1000
> bind 0 1 1001
> set-pub 0100 c000 1 0 1001
> set-pub 0100 c000 1 0 1000
> back
> mesh-info
> 
> Steve
> 
>         "elements":[
>           {
>             "elementIndex":0,
>             "unicastAddress":"0100",
>             "models":[
>               {
>                 "modelId":"1000",
>                 "bind":[
>                   1
>                 ],
>                 "publish":{
>                   "address":"c000",
>                   "index":"0001",
>                   "ttl":255
>                 }
>               },
>               {
>                 "modelId":"1001",
>                 "bind":[
>                   1
>                 ]
>               },
>               {
>                 "modelId":"1001",
>                 "publish":{
>                   "address":"c000",
>                   "index":"0001",
>                   "ttl":255
>                 }
>               }
>             ]
>           },
>           {

The calling sequence is

prov_db_node_set_model_pub()
  get_jmodel_obj()
    parse_configuration_models()
    
There seems to be a problem in parse_configuration_models(). In the
loop looking for the model that matches the target_id, if the first
model matches, the model object is returned and the function exits.

If the loop has to iterate, it next calls parse_bindings(). That
function looks to see if the binding already exists and because it
does, exits false with jmodel set to null.

The consequence is the addition of a second modelId object for the same
 model id.

I'm not familiar with the code and am not sure how to fix this.

Steve



