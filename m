Return-Path: <linux-bluetooth-owner@vger.kernel.org>
MIME-Version: 1.0
In-Reply-To: <20170913181625.27309-1-brian.gix@intel.com>
References: <20170913181625.27309-1-brian.gix@intel.com>
From: Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date: Thu, 14 Sep 2017 11:24:58 +0300
Message-ID: <CABBYNZLPecO7ZQput20zT1X1gN-dqhZyd++jHSVPRBxsSNiCFQ@mail.gmail.com>
Subject: Re: [PATCH 1/1] Rename sample JSON Databases
To: Brian Gix <brian.gix@intel.com>
Cc: "linux-bluetooth@vger.kernel.org" <linux-bluetooth@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-bluetooth-owner@vger.kernel.org
List-ID: <linux-bluetooth.vger.kernel.org>

Hi Brian,

On Wed, Sep 13, 2017 at 9:16 PM, Brian Gix <brian.gix@intel.com> wrote:
> ---
>  mesh/local_node.json | 4 ++--
>  mesh/prov_db.json    | 4 ++--
>  2 files changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/mesh/local_node.json b/mesh/local_node.json
> index 6591289..5ffa7ad 100644
> --- a/mesh/local_node.json
> +++ b/mesh/local_node.json
> @@ -1,6 +1,6 @@
>  {
> -  "$schema":"file:\/\/\/Bluetooth SIG\/Mesh\/schema\/mesh.jsonschema",
> -  "meshName":"Intel BT Mesh",
> +  "$schema":"file:\/\/\/BlueZ\/Mesh\/local_schema\/mesh.jsonschema",
> +  "meshName":"BT Mesh",
>    "netKeys":[
>      {
>        "index": 0,
> diff --git a/mesh/prov_db.json b/mesh/prov_db.json
> index dbed934..e9d038d 100644
> --- a/mesh/prov_db.json
> +++ b/mesh/prov_db.json
> @@ -1,6 +1,6 @@
>  {
> -  "$schema":"file:\/\/\/Bluetooth SIG\/Mesh\/schema\/mesh.jsonschema",
> -  "meshName":"Intel BT Mesh",
> +  "$schema":"file:\/\/\/BlueZ\/Mesh\/schema\/mesh.jsonschema",
> +  "meshName":"BT Mesh",
>    "IVindex":1,
>    "IVupdate":0,
>    "netKeys":[
> --
> 2.9.5

Applied, thanks.

-- 
Luiz Augusto von Dentz
